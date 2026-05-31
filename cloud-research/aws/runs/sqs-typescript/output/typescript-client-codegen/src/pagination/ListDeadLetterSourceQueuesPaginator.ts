// smithy-typescript generated code
import { SQSClient } from "../SQSClient";
import {
  ListDeadLetterSourceQueuesCommand,
  ListDeadLetterSourceQueuesCommandInput,
  ListDeadLetterSourceQueuesCommandOutput,
} from "../commands/ListDeadLetterSourceQueuesCommand";
import { SQSPaginationConfiguration } from "./Interfaces";
import { createPaginator } from "@smithy/core";
import { Paginator } from "@smithy/types";

/**
 * @public
 */
export const paginateListDeadLetterSourceQueues: (
    config: SQSPaginationConfiguration,
    input: ListDeadLetterSourceQueuesCommandInput,
    ...rest: any[]
) => Paginator<ListDeadLetterSourceQueuesCommandOutput> =
    createPaginator<SQSPaginationConfiguration, ListDeadLetterSourceQueuesCommandInput, ListDeadLetterSourceQueuesCommandOutput>(
        SQSClient,
        ListDeadLetterSourceQueuesCommand,
        "NextToken",
        "NextToken",
        "MaxResults"
    );
