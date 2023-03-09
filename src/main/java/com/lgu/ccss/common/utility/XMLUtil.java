package com.lgu.ccss.common.utility;

import java.util.ArrayList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;
import com.thoughtworks.xstream.io.xml.XmlFriendlyNameCoder;

public class XMLUtil {

    public static String toXML(Object object) {

        StringBuilder xml = new StringBuilder("<?xml version=\"1.0\" encoding=\"euc-kr\"?>\n");

        if (object != null) {
            XmlFriendlyNameCoder replacer = new XmlFriendlyNameCoder("__", "_");
            XStream xstream = new XStream(new DomDriver("UTF-8", replacer));

            xstream.processAnnotations(object.getClass());

            xml.append(xstream.toXML(object));
        }

        return xml.toString();
    }

    public static void main(String[] args) throws Exception {
        XMLUtil xml = new XMLUtil("E:/www/WEB-INF/conf/serviceInit.xml");

        NodeList nodes = xml.getNodes("/init/paging");
        String pagingType = "";
        Node node;
        for (int i = 0; i < nodes.getLength(); i++) {
            pagingType = xml.getAttributeValue("/init/paging", i, "type");

            node = nodes.item(i);
            NodeList cNodes = node.getChildNodes();
            for (int j = 0; j < cNodes.getLength(); j++) {
                if (!cNodes.item(j).getNodeName().equals("#text"))
                    System.out.println(cNodes.item(j).getNodeName() + "\n" + cNodes.item(j).getTextContent());
            }
        }
        System.out.println(pagingType);
    }

    XPathFactory factory = XPathFactory.newInstance();

    XPath xpath = factory.newXPath();

    Document doc = null;

    public XMLUtil(String xmlPath) throws Exception {
        DocumentBuilderFactory domFactory = DocumentBuilderFactory.newInstance();
        domFactory.setNamespaceAware(true); // never forget this!
        DocumentBuilder builder = domFactory.newDocumentBuilder();

        if (xmlPath.startsWith("http://")) {
            // url인 경우
            doc = builder.parse(xmlPath);
        } else {
            Resource envLocation = new ClassPathResource(xmlPath);      
            doc = builder.parse(envLocation.getInputStream());
        }
        // 물리적인 경로 파일경로인 경우
        //doc = builder.parse(new File(xmlPath));
        
    }

    /**
     * 노드구하기
     * 
     * @param nodePath
     *            : 노드경로
     * @param idx
     *            : 순번
     * @return
     * @throws javax.xml.xpath.XPathExpressionException
     */
    public Node getNode(String nodePath, int idx) throws XPathExpressionException {
        NodeList nodes = getNodes(nodePath);

        return nodes.item(idx);
    }

    /**
     * 첫번째 노드구하기
     * 
     * @param nodePath
     *            : 노드경로
     * @return
     * @throws javax.xml.xpath.XPathExpressionException
     */
    public Node getNode(String nodePath) throws XPathExpressionException {
        return getNode(nodePath, 0);
    }

    /**
     * 노드리스트구하기
     * 
     * @param nodePath
     *            : 노드경로
     * @return
     * @throws javax.xml.xpath.XPathExpressionException
     */
    public NodeList getNodes(String nodePath) throws XPathExpressionException {
        XPathExpression expr = xpath.compile(nodePath);
        Object result = expr.evaluate(doc, XPathConstants.NODESET);
        NodeList nodes = (NodeList) result;

        return nodes;
    }

    /**
     * 자식노드구하기
     * 
     * @param node
     *            : 노드
     * @return
     * @throws javax.xml.xpath.XPathExpressionException
     */
    public NodeList getChildNodes(Node node) throws XPathExpressionException {
        return node.getChildNodes();
    }

    /**
     * 노드값구하기
     * 
     * @param nodePath
     *            : 노드경로
     * @param idx
     *            : 순번
     * @return
     * @throws javax.xml.xpath.XPathExpressionException
     */
    public String getNodeValue(String nodePath, int idx) throws XPathExpressionException {
        Node cNode = getNode(nodePath, idx);
        String result = cNode.getTextContent();

        return result;
    }

    /**
     * 첫번째 노드값구하기
     * 
     * @param nodePath
     *            : 노드경로
     * @return
     * @throws javax.xml.xpath.XPathExpressionException
     */
    public String getNodeValue(String nodePath) throws XPathExpressionException {
        return getNodeValue(nodePath, 0);
    }

    /**
     * 노드값구하기
     * 
     * @param nodePath
     *            : 노드경로
     * @return
     * @throws javax.xml.xpath.XPathExpressionException
     */
    public ArrayList<Object> getNodeValues(String nodePath) throws XPathExpressionException {
        NodeList nodes = getNodes(nodePath);
        ArrayList<Object> list = new ArrayList<Object>();

        for (int i = 0; i < nodes.getLength(); i++) {
            list.add(nodes.item(i).getTextContent());
        }

        return list;
    }

    /**
     * 노드 attribute구하기
     * 
     * @param nodePath
     *            : 노드경로
     * @param idx
     *            : 순번
     * @param attr
     *            : attribute명
     * @return
     * @throws javax.xml.xpath.XPathExpressionException
     */
    public String getAttributeValue(String nodePath, int idx, String attr) throws XPathExpressionException {
        Node node = getNode(nodePath, idx);
        Node attrNode = null;
        NamedNodeMap map = node.getAttributes();
        String attrValue = "";

        for (int i = 0; i < map.getLength(); i++) {
            attrNode = map.item(i);
            if (attr.equals(attrNode.getNodeName())) {
                attrValue = attrNode.getNodeValue();
                break;
            }
        }

        return attrValue;
    }

    /**
     * 첫번째 노드 attribute구하기
     * 
     * @param nodePath
     *            : 노드경로
     * @param attr
     *            : attribute명
     * @return
     * @throws javax.xml.xpath.XPathExpressionException
     */
    public String getAttributeValue(String nodePath, String attr) throws XPathExpressionException {
        return getAttributeValue(nodePath, 0, attr);
    }
}
