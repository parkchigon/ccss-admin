package com.lgu.ccss.common.utility.keygenerator;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


// FLK Global Unique Object ID
// 58bit
//  1bit	- sign bit(not used)
// 41bit	- timestamp after 2011 year, for 70 year.
//  2bit	- 4 DB Set
//  5bit	- 32 Instance
// 10bit	- 1024 Table Set

public class FGOID {
	
	private static final Logger logger = LoggerFactory.getLogger(FGOID.class);

	final static long START_STANDARD_TIME = 1293807600001L;//20110101 00:00:00 001, as 20800906 15:47:35 552 valid
	final static long LAST_STANDARD_TIME = 3492830855553L;//20800906 15:47:35 552
	final static int instanceIdBits = 7;
	final static int dbSetIdBits = 2;
	final static int maxInstanceId = -1 ^ (-1 << instanceIdBits);
	final static int maxDbSetId = -1 ^ (-1 << dbSetIdBits);	
	final static int tableSetBits = 10;
	final static int maxtableSetId = -1 ^ (-1 << tableSetBits);
	final static int dbSetIdShift = instanceIdBits;
	final static int tableSetIdShift = instanceIdBits + dbSetIdBits;
	final static int timestampLeftShift = instanceIdBits + dbSetIdBits + tableSetBits;

	static long lastTimestamp = 0L;

	public static synchronized long getGUID(int dbSetId, int instanceId) throws Exception
	{
		if(dbSetId>maxDbSetId || dbSetId<0)
			throw new Exception("dbSetID is too big or to small 0~"+maxDbSetId);
		if(instanceId>maxInstanceId || instanceId<0)
			throw new Exception("instanceId is too big or to small 0~"+maxInstanceId);
		long timestamp = timeGen();
		if(timestamp < lastTimestamp)
			throw new Exception("Time moved backwards.");
		if(timestamp == lastTimestamp) {
			timestamp = tilNextMillis(lastTimestamp);
	    }
		lastTimestamp = timestamp;
		return ((timestamp - START_STANDARD_TIME) << timestampLeftShift) |
			      (dbSetId << dbSetIdShift) |
			      instanceId;
	}
	/**
	 * Get a DB System & Instance Unique ID
	 * @author fulstory
	 * @param dbSetId DB System ID( normal configuration)
	 * @param instanceId( normal configuration)
	 * @param tableSetId( normal configuration)
	 * @return
	 * @throws Exception
	 */
	public static synchronized long getGUID(int dbSetId, int instanceId, int tableSetId) throws Exception
	{
		if(dbSetId>maxDbSetId || dbSetId<0)
			throw new Exception("dbSetID is too big or to small 0~"+maxDbSetId);
		if(instanceId>maxInstanceId || instanceId<0)
			throw new Exception("instanceId is too big or to small 0~"+maxInstanceId);
		if(tableSetId>maxtableSetId || tableSetId<0)
			throw new Exception("tableSetId is too big or to small 0~"+maxtableSetId);
		long timestamp = timeGen();
		if(timestamp < lastTimestamp)
			throw new Exception("Time moved backwards.");
		if(timestamp == lastTimestamp) {
			timestamp = tilNextMillis(lastTimestamp);
		}
		lastTimestamp = timestamp;
		return ((timestamp - START_STANDARD_TIME) << timestampLeftShift) | (tableSetId << tableSetIdShift) | (dbSetId << dbSetIdShift) | instanceId;
	}

	public static int getTableSetId(long guid) throws Exception {
		try {
			String s = Long.toBinaryString(guid).substring(Long.toBinaryString(guid>>timestampLeftShift).length(), Long.toBinaryString(guid>>tableSetIdShift).length());
			return Integer.parseInt(s, 2);
		}catch (Exception e) {
			logger.error("Exception", e);	
			throw new Exception();
		}
	}
	public static int getDbSetId(long guid) throws Exception {
		try {
			String s = Long.toBinaryString(guid).substring(Long.toBinaryString(guid>>tableSetIdShift).length(), Long.toBinaryString(guid>>dbSetIdBits).length());
			return Integer.parseInt(s, 2);
		} catch (Exception e) {
			logger.error("Exception", e);	
			throw new Exception();
		}
	}

	public static int getInstanceId(long instanceId) throws Exception {
		try {
			String s = Long.toBinaryString(instanceId).substring(Long.toBinaryString(instanceId>>instanceIdBits).length(), Long.toBinaryString(instanceId).length());
			return Integer.parseInt(s, 2);
		} catch (Exception e) {
			logger.error("Exception", e);	
			throw new Exception();
		}
	}

	/**
	 * Get a Timestamp
	 * @author fulstory
	 * param guid input GUID
	 * @param dbSetId DB System ID( normal configuration)
	 * @param instanceId( normal configuration)
	 * @return
	 * @throws Exception
	 */
	public static long getTimestamp(long guid, int dbSetId, int instanceId) throws Exception
	{
		if(dbSetId>maxDbSetId || dbSetId<0)
			throw new Exception("dbSetID is too big or to small 0~"+maxDbSetId);
		if(instanceId>maxInstanceId || instanceId<0)
			throw new Exception("instanceId is too big or to small 0~"+maxInstanceId);
		return (guid ^ (dbSetId << dbSetIdShift) ^ instanceId) >> timestampLeftShift;
	}

	private static long timeGen()
	{
		long now = System.currentTimeMillis();
		if(now>LAST_STANDARD_TIME)
			now = now - LAST_STANDARD_TIME;
		return now;
	}

	private static long tilNextMillis(long currentLastTimestamp)
	{
		long timestamp = timeGen();
		while (timestamp <= currentLastTimestamp) {
			sleep();
			timestamp = timeGen();
		}
		return timestamp;
	}

	private static void sleep()
	{
		try
		{
			Thread.sleep(1);
		}
		catch(Exception e)
		{
			logger.error("Exception", e);	
		}
	}
}
