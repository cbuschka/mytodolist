package com.github.cbuschka.mytodolist.lambda.post_list;

import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
import com.amazonaws.services.dynamodbv2.document.DynamoDB;
import com.amazonaws.services.dynamodbv2.document.Item;
import com.amazonaws.services.dynamodbv2.document.Table;
import com.amazonaws.services.dynamodbv2.document.spec.PutItemSpec;
import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.github.cbuschka.mytodolist.lambda.AppContext;
import com.github.codestickers.Used;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.UUID;

public class PostListEntryPoint implements RequestHandler<PostListRequest, PostListRequest>
{
	private static final Logger log = LoggerFactory.getLogger(PostListEntryPoint.class);

	private AppContext appContext = new AppContext();

	@Used("Required by AWS lambda runtime.")
	public PostListEntryPoint()
	{
	}

	@Override
	public PostListRequest handleRequest(PostListRequest request, Context context)
	{
		log.info("This is version={}.", this.appContext.getVersion());

		try
		{
			log.info("Got: {}", this.appContext.getObjectMapper().writer().writeValueAsString(request));

			if (request.uuid == null)
			{
				request.uuid = UUID.randomUUID().toString();
			}
			else
			{
				request.uuid = UUID.fromString(request.uuid).toString();
			}

			if (request.version == 0)
			{
				request.version = 1;
			}

			AmazonDynamoDB dbClient = this.appContext.getDb();
			DynamoDB dynamoDB = new DynamoDB(dbClient);
			Table listTable = dynamoDB.getTable(this.appContext.getListTableName());
			listTable.putItem(new PutItemSpec()
					.withItem(new Item()
							.withPrimaryKey("id", request.uuid)
							.withInt("version", request.version)
							.withJSON("data", this.appContext.getObjectMapper().writer().writeValueAsString(request)))
					.withConditionExpression("attribute_not_exists(id)"));

			return request;
		}
		catch (Exception ex)
		{
			log.error("Processing failed.", ex);

			throw new RuntimeException(ex);
		}
	}
}
