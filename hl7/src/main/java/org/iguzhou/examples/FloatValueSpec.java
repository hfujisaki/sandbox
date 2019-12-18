package org.iguzhou.examples;

public class FloatValueSpec extends AbstractValueSpec
{
	private String unit;
	
	public FloatValueSpec(int digits, int decimals, String unit)
	{
		super("F" + digits + '.' + decimals);
		
		this.unit = unit;
	}
	
	public String getUnit()
	{
		return unit;
	}
	
	@Override
	public String toString()
	{
		return "{\"format\": \"" + format + "\", \"unit\": \"" + unit + "\"}";
	}
}
