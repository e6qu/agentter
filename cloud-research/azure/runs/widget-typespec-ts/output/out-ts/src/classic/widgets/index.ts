// Licensed under the MIT License.

import { WidgetServiceContext } from "../../api/widgetServiceContext.js";
import { get } from "../../api/widgets/operations.js";
import { WidgetsGetOptionalParams } from "../../api/widgets/options.js";
import { Widget } from "../../models/models.js";

/** Interface representing a Widgets operations. */
export interface WidgetsOperations {
  /** Get a widget by name. */
  get: (widgetName: string, options?: WidgetsGetOptionalParams) => Promise<Widget>;
}

function _getWidgets(context: WidgetServiceContext) {
  return {
    get: (widgetName: string, options?: WidgetsGetOptionalParams) =>
      get(context, widgetName, options),
  };
}

export function _getWidgetsOperations(context: WidgetServiceContext): WidgetsOperations {
  return {
    ..._getWidgets(context),
  };
}
