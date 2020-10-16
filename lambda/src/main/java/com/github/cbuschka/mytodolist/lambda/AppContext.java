package com.github.cbuschka.mytodolist.lambda;

import com.amazonaws.regions.Regions;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder;
import com.fasterxml.jackson.databind.ObjectMapper;

public class AppContext
{
	private final AmazonDynamoDB db;

	private final ObjectMapper objectMapper = new ObjectMapper();

	public AppContext()
	{
		db = AmazonDynamoDBClientBuilder.standard()
				.withRegion(Regions.EU_CENTRAL_1)
				.build();
	}

	public String getListTableName()
	{
		String scope = System.getenv("SCOPE");
		if (scope == null)
		{
			scope = "";
		}
		return scope + "lists";
	}

	public ObjectMapper getObjectMapper()
	{
		return objectMapper;
	}

	public AmazonDynamoDB getDb()
	{
		return db;
	}

	public String getVersion()
	{
		String version = System.getenv("VERSION");
		if (version == null)
		{
			version = "unknown";
		}
		return version;
	}
}
