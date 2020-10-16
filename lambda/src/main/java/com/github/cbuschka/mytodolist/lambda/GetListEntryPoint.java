package com.github.cbuschka.mytodolist.lambda;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.github.codestickers.Used;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.HashMap;
import java.util.Map;

public class GetListEntryPoint implements RequestHandler<Map<String, Object>, Map<String, Object>>
{
	private static final Logger log = LoggerFactory.getLogger(GetListEntryPoint.class);

	@Used("Required by AWS lambda runtime.")
	public GetListEntryPoint()
	{
	}

	@Override
	public Map<String, Object> handleRequest(Map<String, Object> request, Context lambdaContext)
	{
		log.info("Got: {}", request);

		HashMap<String, Object> response = new HashMap<>();

		log.info("Answering: {}", response);

		return response;
	}
}
