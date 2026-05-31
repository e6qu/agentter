import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ClientGenerator.Core;

/** Minimal TypeSpec service to drive the Azure TypeScript emitter. */
@service(#{ title: "Widget Service" })
@server("https://example.azure.com", "endpoint")
namespace WidgetService;

/** A widget. */
model Widget {
  @key name: string;
  color?: "red" | "green" | "blue";
  weight?: int32;
}

@route("/widgets")
interface Widgets {
  /** Get a widget by name. */
  @get get(@path widgetName: string): Widget;
}
