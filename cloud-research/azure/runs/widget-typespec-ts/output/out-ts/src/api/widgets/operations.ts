// Licensed under the MIT License.

import { WidgetServiceContext as Client } from "../index.js";
import { Widget, widgetDeserializer } from "../../models/models.js";
import { expandUrlTemplate } from "../../static-helpers/urlTemplate.js";
import { WidgetsGetOptionalParams } from "./options.js";
import {
  StreamableMethod,
  PathUncheckedResponse,
  createRestError,
  operationOptionsToRequestParameters,
} from "@typespec/ts-http-runtime";

export function _getSend(
  context: Client,
  widgetName: string,
  options: WidgetsGetOptionalParams = { requestOptions: {} },
): StreamableMethod {
  const path = expandUrlTemplate(
    "/widgets/{widgetName}",
    {
      widgetName: widgetName,
    },
    {
      allowReserved: options?.requestOptions?.skipUrlEncoding,
    },
  );
  return context
    .path(path)
    .get({
      ...operationOptionsToRequestParameters(options),
      headers: { accept: "application/json", ...options.requestOptions?.headers },
    });
}

export async function _getDeserialize(result: PathUncheckedResponse): Promise<Widget> {
  const expectedStatuses = ["200"];
  if (!expectedStatuses.includes(result.status)) {
    throw createRestError(result);
  }

  return widgetDeserializer(result.body);
}

/** Get a widget by name. */
export async function get(
  context: Client,
  widgetName: string,
  options: WidgetsGetOptionalParams = { requestOptions: {} },
): Promise<Widget> {
  const result = await _getSend(context, widgetName, options);
  return _getDeserialize(result);
}
