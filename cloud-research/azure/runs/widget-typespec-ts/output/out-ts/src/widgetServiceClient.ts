// Licensed under the MIT License.

import {
  WidgetServiceContext,
  WidgetServiceClientOptionalParams,
  createWidgetService,
} from "./api/index.js";
import { WidgetsOperations, _getWidgetsOperations } from "./classic/widgets/index.js";
import { Pipeline } from "@typespec/ts-http-runtime";

export type { WidgetServiceClientOptionalParams } from "./api/widgetServiceContext.js";

export class WidgetServiceClient {
  private _client: WidgetServiceContext;
  /** The pipeline used by this client to make requests */
  public readonly pipeline: Pipeline;

  /** Minimal TypeSpec service to drive the Azure TypeScript emitter. */
  constructor(options: WidgetServiceClientOptionalParams = {}) {
    const prefixFromOptions = options?.userAgentOptions?.userAgentPrefix;
    const userAgentPrefix = prefixFromOptions
      ? `${prefixFromOptions} azsdk-js-client`
      : `azsdk-js-client`;
    this._client = createWidgetService({ ...options, userAgentOptions: { userAgentPrefix } });
    this.pipeline = this._client.pipeline;
    this.widgets = _getWidgetsOperations(this._client);
  }

  /** The operation groups for widgets */
  public readonly widgets: WidgetsOperations;
}
