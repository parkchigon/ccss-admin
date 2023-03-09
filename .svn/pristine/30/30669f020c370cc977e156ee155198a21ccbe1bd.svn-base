package com.lgu.ccss.common.domain;

/**
 * The Class SngpException.
 */
@SuppressWarnings("serial")
public class FCException extends RuntimeException{

	/** Exception Code */
	String code;
	
	/**
	 * constructor.
	 * 
	 * @param message
	 *            the message
	 */
	public FCException(String message) {
		super(message);
	}

	/**
	 * constructor.
	 * 
	 * @param code
	 *            the code
	 * @param message
	 *            the message
	 */
	public FCException(String code, String message) {
		super(message);
		this.code = code;
	}

	/**
	 * Instantiates a new sngp exception.
	 *
	 * @param errCode the err code
	 */
	public FCException(FCErrCode errCode) {
		super(errCode.getMessage());
		this.code = errCode.getCode();
	}

	/**
	 * Gets the code.
	 * 
	 * @return the code
	 */
	public String getCode() {
		return code;
	}

	/**
	 * Sets the code.
	 * 
	 * @param code
	 *            the new code
	 */
	public void setCode(String code) {
		this.code = code;
	}

	/* (non-Javadoc)
	 * @see java.lang.Throwable#getMessage()
	 */
	@Override
	public String getMessage() {
		String message = super.getMessage();
		if (message == null) {
			return getLocalizedMessage();
		}
		return message;
	}

	/* (non-Javadoc)
	 * @see java.lang.Throwable#getLocalizedMessage()
	 */
	@Override
	public String getLocalizedMessage() {
		return super.getMessage();
	}

}
