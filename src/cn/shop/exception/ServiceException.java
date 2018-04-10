package cn.shop.exception;

/**
 * 在 Service 层次一律抛出 ServiceException
 */
public class ServiceException extends RuntimeException {

	private static final long serialVersionUID = -108566045367563748L;

	public ServiceException(String message, Throwable cause) {
		super(message, cause);
	}

	public ServiceException(String message) {
		super(message);
	}

}
