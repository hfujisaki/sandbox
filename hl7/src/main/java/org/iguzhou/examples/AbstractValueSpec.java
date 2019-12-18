package org.iguzhou.examples;

public abstract class AbstractValueSpec implements IValueSpec
{
	protected final String format;
	
	public AbstractValueSpec(String format)
	{
		this.format = format;
	}
	
	public String getFormat()
	{
		return format;
	}
	
	@Override
	public String toString()
	{
		return "{\"format\": \"" + format + "\"}";
	}
}
