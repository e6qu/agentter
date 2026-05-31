# Twilio Helper Libraries: SDK Code Generation

Twilio ships official "helper libraries" for seven languages (Python, Node/TS,
Go, Java, C#, Ruby, PHP). Unlike providers that wrote a bespoke generator from
scratch, **Twilio's pipeline is a thin, opinionated layer on top of the
open-source [OpenAPI Generator](https://openapi-generator.tech)**: per-product
OpenAPI specs feed a *custom generator* whose language backends each `extends`
an OpenAPI Generator language codegen class, paired with Twilio-specific
templates. The hand-written core HTTP/auth/pagination runtime lives in each SDK
repo and is *not* generated.

All repos referenced below are MIT-licensed.

Commit pins used throughout:
- `twilio/twilio-oai` @ `7efd1f014b839ba7ac23cf52a28a87e618e7b220`
- `twilio/twilio-oai-generator` @ `fdb2209d32ad56a8da73fc5a838966c2f0a4eacd`
- `twilio/twilio-python` @ `82adf8fd99a82492982e4cb6b770829f86d378bf`

---

## 1. Source of truth = OpenAPI

The API contract lives in **`twilio/twilio-oai`** (described as "The Twilio
OpenAPI Specification", MIT). It publishes **one OpenAPI 3.0.1 document per
product+version** under `spec/json/twilio_*.json` (and a parallel
`spec/yaml/` tree). Examples: `twilio_accounts_v1.json`,
`twilio_api_v2010.json`, `twilio_conversations_v1.json`,
`twilio_messaging_v1.json`, etc.

Quoting the head of `spec/json/twilio_accounts_v1.json`:

```json
{
  "components": {
    "securitySchemes": {
      "accountSid_authToken": {
        "scheme": "basic",
        "type": "http"
      }
    },
    "schemas": {
      "accounts.v1.auth_token_promotion": {
        "type": "object",
        "properties": {
          "account_sid": {
            "type": "string",
            "minLength": 34,
            "maxLength": 34,
            "pattern": "^AC[0-9a..."
```

and its `info` / first path:

```json
"info": {
  "title": "Twilio - Accounts",
  "version": "1.0.0",
  "contact": { "name": "Twilio Support", "url": "https://support.twilio.com", "email": "support@twilio.com" }
}
...
"paths": { "/v1/AuthTokens/Promote": { ... } }
```

So the spec is plain OpenAPI 3.0.1 with HTTP basic auth (account SID + auth
token), Twilio resource schemas, and REST paths — the single source of truth all
seven SDKs are derived from.

→ [`spec/json/twilio_accounts_v1.json`](https://github.com/twilio/twilio-oai/blob/7efd1f014b839ba7ac23cf52a28a87e618e7b220/spec/json/twilio_accounts_v1.json)

---

## 2. The generator = `twilio/twilio-oai-generator` (custom, built ON TOP OF OpenAPI Generator)

**This is the key finding.** `twilio/twilio-oai-generator` (MIT, "Twilio
OpenAPI client generator") is a Maven Java project that does **not**
reimplement codegen. It declares a dependency on `openapi-generator-cli`
(version **7.13.0** at this pin) and ships one Java class per language, each of
which `extends` the corresponding *upstream OpenAPI Generator* language codegen
class and then customizes it.

From `pom.xml`:

```xml
<artifactId>openapi-generator-cli</artifactId>
<version>${openapi-generator-version}</version>
...
<openapi-generator-version>7.13.0</openapi-generator-version>
```

The custom codegen classes (`src/main/java/com/twilio/oai/`) and their parents —
all verified by reading the `public class ... extends ...` line:

| Twilio class | extends (OpenAPI Generator base) |
|---|---|
| `TwilioPythonGenerator` | `PythonClientCodegen` |
| `TwilioNodeGenerator` | `TypeScriptNodeClientCodegen` |
| `TwilioGoGenerator` | `AbstractTwilioGoGenerator` → `GoClientCodegen` |
| `TwilioJavaGenerator` | `JavaClientCodegen` |
| `TwilioCsharpGenerator` | `CSharpClientCodegen` |
| `TwilioRubyGenerator` | `RubyClientCodegen` |
| `TwilioPhpGenerator` | `PhpClientCodegen` |

Concrete proof — `TwilioPythonGenerator.java` (line 34):

```java
package com.twilio.oai;
...
import org.openapitools.codegen.languages.PythonClientCodegen;
...
public class TwilioPythonGenerator extends PythonClientCodegen {
    ...
    public String getName() {
        return EnumConstants.Generator.TWILIO_PYTHON.getValue();
    }
}
```

The imports (`org.openapitools.codegen.*`) confirm it is built directly on the
OpenAPI Generator framework, registering a named generator (`twilio-python`)
that OpenAPI Generator's CLI discovers and runs. The generator README confirms
the workflow: you build this project into a JAR and "use that with OpenAPI
Generator", passing Twilio's custom templates.

### Twilio-specific templates (mustache + handlebars)

Each language has its own template tree under `src/main/resources/twilio-<lang>/`
(e.g. `twilio-python/`, `twilio-csharp/`, `twilio-go/`,
`terraform-provider-twilio/`). These override OpenAPI Generator's stock
templates with Twilio's resource/pagination/options shapes. The Python
templates wire generated code into Twilio's hand-written runtime — e.g.
`twilio-python/api-single.mustache`:

```mustache
{{>licenseInfo}}
{{#resources}}
...
from twilio.base import deserialize, serialize, values
from twilio.base.api_response import ApiResponse
from twilio.base.list_resource import ListResource
from twilio.base.version import Version
{{#hasPaginationOperation}}...from twilio.base.page import Page...{{/hasPaginationOperation}}
```

(Note: Twilio also uses a custom Handlebars engine adapter —
`TwilioHandlebarsEngineAdapter` / `TwilioHelpers` — so some templates are
`.handlebars` rather than `.mustache`, e.g. `twilio-python/licenseInfo.handlebars`.)

→ [`TwilioPythonGenerator.java`](https://github.com/twilio/twilio-oai-generator/blob/fdb2209d32ad56a8da73fc5a838966c2f0a4eacd/src/main/java/com/twilio/oai/TwilioPythonGenerator.java)
→ [`api-single.mustache`](https://github.com/twilio/twilio-oai-generator/blob/fdb2209d32ad56a8da73fc5a838966c2f0a4eacd/src/main/resources/twilio-python/api-single.mustache)
→ [`pom.xml`](https://github.com/twilio/twilio-oai-generator/blob/fdb2209d32ad56a8da73fc5a838966c2f0a4eacd/pom.xml)

---

## 3. Per-language SDKs generated from the spec

The generator produces the REST resource layer for each official helper
library (all MIT):

`twilio-python`, `twilio-node`, `twilio-go`, `twilio-java`, `twilio-csharp`,
`twilio-ruby`, `twilio-php`.

Generated files carry Twilio's signature DO-NOT-EDIT header (rendered from
`licenseInfo.handlebars`). From the generated
`twilio-python/twilio/rest/accounts/v1/auth_token_promotion.py`:

```python
r"""
    This code was generated by
   ___ _ _ _ _ _    _ ____    ____ ____ _    ____ ____ _  _ ____ ____ ____ ___ __   __
    |  | | | | |    | |  | __ |  | |__| | __ | __ |___ |\ | |___ |__/ |__|  | |  | |__/
    |  |_|_| | |___ | |__|    |__| |  | |    |__] |___ | \| |___ |  \ |  |  | |__| |  \

    Twilio - Accounts
    This is the public Twilio REST API.

    NOTE: This class is auto generated by OpenAPI Generator.
    https://openapi-generator.tech
    Do not edit the class manually.
"""
```

The template source for that header
(`twilio-oai-generator/src/main/resources/twilio-python/licenseInfo.handlebars`):

```handlebars
r"""
    This code was generated by
   ... (ASCII art) ...
    {{{appName}}}
    {{{appDescription}}}

    NOTE: This class is auto generated by OpenAPI Generator.
    https://openapi-generator.tech
    Do not edit the class manually.
"""
```

Note the path of the generated file mirrors the spec name:
`twilio_accounts_v1.json` → `twilio/rest/accounts/v1/...`, and the schema
`accounts.v1.auth_token_promotion` → `auth_token_promotion.py`.

→ generated header: [`twilio/rest/accounts/v1/auth_token_promotion.py`](https://github.com/twilio/twilio-python/blob/82adf8fd99a82492982e4cb6b770829f86d378bf/twilio/rest/accounts/v1/auth_token_promotion.py)
→ template: [`licenseInfo.handlebars`](https://github.com/twilio/twilio-oai-generator/blob/fdb2209d32ad56a8da73fc5a838966c2f0a4eacd/src/main/resources/twilio-python/licenseInfo.handlebars)

---

## 4. Generated vs hand-written

**Generated** = the REST resource classes, one tree per product/version
(`twilio/rest/<product>/<version>/...` in twilio-python; analogous layout in
the other SDKs). These carry the "Do not edit" header above.

**Hand-written** = the core runtime the generated code imports but never
emits: HTTP client, auth/token management, request/response wrappers,
serialization, pagination, exceptions. In twilio-python these live in two
directories and have **no** auto-generated header:

- `twilio/base/` — `client_base.py`, `version.py`, `domain.py`,
  `list_resource.py`, `instance_resource.py`, `instance_context.py`,
  `page.py`, `token_pagination.py`, `serialize.py`, `deserialize.py`,
  `values.py`, `api_response.py`, `exceptions.py`
- `twilio/http/` — `http_client.py`, `async_http_client.py`, `request.py`,
  `response.py`, `token_manager.py`, `client_token_manager.py`,
  `orgs_token_manager.py`, `validation_client.py`

For example `twilio/base/page.py` begins with ordinary code, no OpenAPI
Generator banner:

```python
import json
from typing import Any, Dict, Optional

from twilio.base.exceptions import TwilioException
from twilio.http.response import Response


class Page(object):
    """
    Represents a page of records in a collection.
    ...
```

This is the division of labor: the generator emits the *surface* (typed
resource methods per API), and the hand-authored `base/`+`http/` packages
provide the *plumbing* (auth, transport, pagination iterators) that the
generated `api-single.mustache` template explicitly imports
(`from twilio.base.version import Version`, `from twilio.base.page import Page`,
etc.).

→ hand-written runtime: [`twilio/base/`](https://github.com/twilio/twilio-python/tree/82adf8fd99a82492982e4cb6b770829f86d378bf/twilio/base) · [`twilio/http/`](https://github.com/twilio/twilio-python/tree/82adf8fd99a82492982e4cb6b770829f86d378bf/twilio/http)
→ example hand-written file: [`twilio/base/page.py`](https://github.com/twilio/twilio-python/blob/82adf8fd99a82492982e4cb6b770829f86d378bf/twilio/base/page.py)

---

## 5. Multi-language strategy (summary)

```
 twilio/twilio-oai
   spec/json/twilio_<product>_<version>.json   (OpenAPI 3.0.1, one per product)
            │
            ▼
 twilio/twilio-oai-generator  (Maven/Java)
   depends on openapi-generator-cli 7.13.0
   Twilio<Lang>Generator  extends  <Lang>ClientCodegen   (one per language)
   + src/main/resources/twilio-<lang>/*.mustache|*.handlebars
            │  (run via OpenAPI Generator CLI with custom JAR + templates)
            ▼
 per-language helper libs (MIT):
   twilio-python / -node / -go / -java / -csharp / -ruby / -php
     generated:    rest/<product>/<version>/*  ("Do not edit ... OpenAPI Generator")
     hand-written: base/ + http/ runtime (auth, transport, pagination, (de)serialize)
```

One OpenAPI spec set → one custom-but-OpenAPI-Generator-based generator →
seven language SDKs, each = generated resource layer + hand-maintained core
runtime. The same generator also targets a Terraform provider
(`terraform-provider-twilio` templates + `TwilioTerraformGenerator`).

---

## Gaps / `?? verify`

- **CI/orchestration not yet traced.** I confirmed *what* generates and *what*
  is hand-written, but did not pin the exact CI workflow / Makefile that
  invokes OpenAPI Generator + this JAR to regenerate each SDK repo, nor how
  spec updates in `twilio-oai` propagate (build trigger/cadence). `?? verify`
  — check `.github/workflows/` and `Makefile` in `twilio-oai-generator` and in
  each SDK repo.
- **Per-language template parity.** I quoted Python templates and the
  C#/Terraform template trees exist; I did not enumerate every language's
  template set or its hand-written-vs-generated boundary (verified concretely
  only for twilio-python). `?? verify` for node/go/java/ruby/php base layers.
- **`TwilioJavaGeneratorModern`** exists alongside `TwilioJavaGenerator` —
  suggests a newer Java codegen path; relationship/active-default not
  investigated. `?? verify`.
- Mix of `.mustache` and `.handlebars` templates (custom
  `TwilioHandlebarsEngineAdapter`) — the split of which templates use which
  engine was not fully mapped. `?? verify`.

---

## Links

- twilio-oai (spec, MIT): https://github.com/twilio/twilio-oai/tree/7efd1f014b839ba7ac23cf52a28a87e618e7b220
  - spec example: https://github.com/twilio/twilio-oai/blob/7efd1f014b839ba7ac23cf52a28a87e618e7b220/spec/json/twilio_accounts_v1.json
- twilio-oai-generator (generator, MIT): https://github.com/twilio/twilio-oai-generator/tree/fdb2209d32ad56a8da73fc5a838966c2f0a4eacd
  - TwilioPythonGenerator.java: https://github.com/twilio/twilio-oai-generator/blob/fdb2209d32ad56a8da73fc5a838966c2f0a4eacd/src/main/java/com/twilio/oai/TwilioPythonGenerator.java
  - codegen classes dir: https://github.com/twilio/twilio-oai-generator/tree/fdb2209d32ad56a8da73fc5a838966c2f0a4eacd/src/main/java/com/twilio/oai
  - api-single.mustache (Python): https://github.com/twilio/twilio-oai-generator/blob/fdb2209d32ad56a8da73fc5a838966c2f0a4eacd/src/main/resources/twilio-python/api-single.mustache
  - licenseInfo.handlebars (Python header): https://github.com/twilio/twilio-oai-generator/blob/fdb2209d32ad56a8da73fc5a838966c2f0a4eacd/src/main/resources/twilio-python/licenseInfo.handlebars
  - pom.xml (openapi-generator-cli 7.13.0): https://github.com/twilio/twilio-oai-generator/blob/fdb2209d32ad56a8da73fc5a838966c2f0a4eacd/pom.xml
- twilio-python (MIT): https://github.com/twilio/twilio-python/tree/82adf8fd99a82492982e4cb6b770829f86d378bf
  - generated resource header: https://github.com/twilio/twilio-python/blob/82adf8fd99a82492982e4cb6b770829f86d378bf/twilio/rest/accounts/v1/auth_token_promotion.py
  - hand-written base/: https://github.com/twilio/twilio-python/tree/82adf8fd99a82492982e4cb6b770829f86d378bf/twilio/base
  - hand-written http/: https://github.com/twilio/twilio-python/tree/82adf8fd99a82492982e4cb6b770829f86d378bf/twilio/http
  - hand-written example (page.py): https://github.com/twilio/twilio-python/blob/82adf8fd99a82492982e4cb6b770829f86d378bf/twilio/base/page.py
- Other helper libs (MIT), pinned:
  - twilio-node @ `e9e546985dcc293e4f71888160725739e7b28c37`: https://github.com/twilio/twilio-node/tree/e9e546985dcc293e4f71888160725739e7b28c37
  - twilio-go @ `d858acdc095564232ae71a5cd1c7b130dad88b73`: https://github.com/twilio/twilio-go/tree/d858acdc095564232ae71a5cd1c7b130dad88b73
  - twilio-java @ `7a10e5a2eb21582ec90fc9c065e8e571ad777bca`: https://github.com/twilio/twilio-java/tree/7a10e5a2eb21582ec90fc9c065e8e571ad777bca
  - twilio-csharp @ `79874c596a929690845f8fd0dc1e8056bae97366`: https://github.com/twilio/twilio-csharp/tree/79874c596a929690845f8fd0dc1e8056bae97366
  - twilio-ruby @ `c58e213a6f04129234b5c6db0b13965e3b0a87ac`: https://github.com/twilio/twilio-ruby/tree/c58e213a6f04129234b5c6db0b13965e3b0a87ac
  - twilio-php @ `57754efb0998086007ec9a63874fd85def5afb7f`: https://github.com/twilio/twilio-php/tree/57754efb0998086007ec9a63874fd85def5afb7f
- OpenAPI Generator (upstream base): https://openapi-generator.tech
