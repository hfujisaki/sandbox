package org.iguzhou.examples.xslt;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.function.Consumer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.iguzhou.examples.EnumValueSpec;
import org.iguzhou.examples.IValueSpec;
import org.iguzhou.examples.FloatValueSpec;
import org.iguzhou.examples.StringValueSpec;
import org.w3c.dom.Element;
import org.w3c.dom.Node;

public class ExtensionFunctions
{
	private static final Map<String, IValueSpec> _specs;
	private static final Set<String> _enums;
	
	private static final Pattern F_FORMAT = Pattern.compile("^F(\\d+)\\.(\\d+)$");
	
	static
	{
		Map<String, IValueSpec> specs = new HashMap<String, IValueSpec>();
		specs.put("A_B_C_D1", new StringValueSpec());
		specs.put("A_B_C_D2", new FloatValueSpec(5, 2, "mA"));
		specs.put("A_B_C_D3_E1", new EnumValueSpec("E1_ENUM"));
		specs.put("A_B_C_D3_E2", new FloatValueSpec(4, 1, "%"));
		specs.put("A_B_C_D4_E3", new EnumValueSpec("E3_ENUM"));
		specs.put("A_B_C_D4_E4", new EnumValueSpec("E4_ENUM"));
		specs.put("Z_Y_X1", new EnumValueSpec("X1_ENUM"));
		_specs = specs;
		
		final Set<String> enums = new HashSet<String>();
		specs.values().forEach(new Consumer<IValueSpec>()
		{
			public void accept(IValueSpec spec)
			{
				if (spec instanceof EnumValueSpec)
				{
					enums.add(spec.getFormat());
				}
			}
		});
		_enums = enums;
	}
	
	public static String name(Node contextNode)
	{
		Element element = (Element)contextNode;
		String name = element.getAttribute("name");
		
		Node parentNode = element.getParentNode();
		if ("section".equals(parentNode.getNodeName()))
		{
			return name(parentNode) + '_' + name;
		}
		else
		{
			return name;
		}
	}
	
	public static IValueSpec spec(Node node)
	{
		return _specs.get(name(node));
	}
	
	public static IValueSpec spec(String name)
	{
		return _specs.get(name);
	}
	
	public static String format(Node node)
	{
		String name = name(node);
		return _specs.containsKey(name)
				? format(_specs.get(name))
				: null;
	}
	
	public static String format(IValueSpec spec)
	{
		return spec.getFormat();
	}
	
	public static String unit(Node node)
	{
		String name = name(node);
		return _specs.containsKey(name)
				? unit(_specs.get(name))
				: null;
	}
	
	public static String unit(IValueSpec spec)
	{
		if (spec instanceof FloatValueSpec)
		{
			return ((FloatValueSpec)spec).getUnit();
		}
		
		return null;
	}
	
	public static String value(Node node)
	{
		String name = name(node);
		return _specs.containsKey(name)
				? value(node.getTextContent(), _specs.get(name).getFormat())
				: null;
	}
	
	public static String value(String value, IValueSpec spec)
	{
		return spec != null ? value(value, spec.getFormat()) : null;
	}
	
	public static String value(String value, String format)
	{
		if (value == null || value.length() == 0) return null;
		
		if (format.equals("String")) return value;
		
		if (_enums.contains(format)) 
		{
			String prefix = format + '_';
			if (value.startsWith(prefix))
			{
				return value.substring(prefix.length());
			}
		}
		
		Matcher m = F_FORMAT.matcher(format);
		if (m.find())
		{
			int digits = Integer.valueOf(m.group(1));
			int decimals = Integer.valueOf(m.group(2));
			System.out.println("digits: " + digits + ", decimals: " + decimals);
			
			return value;
		}
		
		return null;
	}
	
	public static String dump(String name, Object value, boolean b)
	{
		System.out.println("name=" + name + ", value=" + value + ", flag=" + b);
		return null;
	}
	
	public static String extract(Node node)
	{
		System.out.println("Node: " + node);
		return null;
	}
}
