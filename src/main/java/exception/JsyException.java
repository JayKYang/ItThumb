package exception;

public class JsyException extends RuntimeException{
	private String url;
	public JsyException(String msg, String url) {
		super(msg);
		this.url=url;
	}
	public String getUrl() {
		return url;
	}
}
