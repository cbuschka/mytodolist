package com.github.cbuschka.mytodolist.lambda.post_list;

import java.util.List;
import java.util.UUID;

public class PostListRequest
{
	public String uuid;

	public int version;

	public String title;

	public List<Item> items;

	public static class Item
	{
		public UUID uuid;

		public String text;
	}
}
