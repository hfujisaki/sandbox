package org.iguzhou.examples.xslt;

import java.io.File;

import javax.xml.transform.Templates;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

public class AppXslt
{
	public static void main(String[] args) throws Exception
	{
		transform("output.html", "stylesheet-html.xsl");
		transform("output.xml", "stylesheet-xml.xsl");
	}
	
	private static void transform(String outputTargetName, String stylesheetName) throws Exception
	{
		File xmlSource = new File(System.getProperty("user.dir"), "source.xml");
		File outputTarget = new File(System.getProperty("user.dir"), outputTargetName);
		
		File stylesheet = new File(System.getProperty("user.dir"), stylesheetName);
		
		TransformerFactory tf = TransformerFactory.newInstance();
		Templates templates = tf.newTemplates(new StreamSource(stylesheet));
		Transformer t = templates.newTransformer();
		t.transform(new StreamSource(xmlSource), new StreamResult(outputTarget));
		
		System.out.println("output> " + outputTarget.getAbsolutePath());
	}
}
