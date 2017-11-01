package cn.taobao.exception;

/**
 * 在 DAO 层次一律抛出 DaoException
 */
public class DaoException extends RuntimeException {

	private static final long serialVersionUID = 5906195332946763820L;

	public DaoException(String message, Throwable cause) {
		super(message, cause);
	}

	public DaoException(String message) {
		super(message);
	}

}
