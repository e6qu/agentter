// Licensed under the MIT License.

import { Client, ClientOptions, getClient } from "@typespec/ts-http-runtime";

/** Minimal TypeSpec service to drive the Azure TypeScript emitter. */
export interface WidgetServiceContext extends Client {}

/** Optional parameters for the client. */
export interface WidgetServiceClientOptionalParams extends ClientOptions {}

/** Minimal TypeSpec service to drive the Azure TypeScript emitter. */
export function createWidgetService(
  options: WidgetServiceClientOptionalParams = {},
): WidgetServiceContext {
  const endpointUrl = options.endpoint ?? "https://example.azure.com";
  const prefixFromOptions = options?.userAgentOptions?.userAgentPrefix;
  const userAgentInfo = `azsdk-js-WidgetService/1.0.0-beta.1`;
  const userAgentPrefix = prefixFromOptions
    ? `${prefixFromOptions} azsdk-js-api ${userAgentInfo}`
    : `azsdk-js-api ${userAgentInfo}`;
  const { apiVersion: _, ...updatedOptions } = {
    ...options,
    userAgentOptions: { userAgentPrefix },
  };
  const clientContext = getClient(endpointUrl, undefined, updatedOptions);

  if (options.apiVersion) {
    console.warn(
      "This client does not support client api-version, please change it at the operation level",
    );
  }
  return clientContext;
}
