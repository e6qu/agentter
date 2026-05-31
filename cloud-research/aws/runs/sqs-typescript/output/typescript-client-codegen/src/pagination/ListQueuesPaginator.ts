// smithy-typescript generated code
import { SQSClient } from "../SQSClient";
import {
  ListQueuesCommand,
  ListQueuesCommandInput,
  ListQueuesCommandOutput,
} from "../commands/ListQueuesCommand";
import { SQSPaginationConfiguration } from "./Interfaces";
import { createPaginator } from "@smithy/core";
import { Paginator } from "@smithy/types";

/**
 * @public
 */
export const paginateListQueues: (
    config: SQSPaginationConfiguration,
    input: ListQueuesCommandInput,
    ...rest: any[]
) => Paginator<ListQueuesCommandOutput> =
    createPaginator<SQSPaginationConfiguration, ListQueuesCommandInput, ListQueuesCommandOutput>(
        SQSClient,
        ListQueuesCommand,
        "NextToken",
        "NextToken",
        "MaxResults"
    );
