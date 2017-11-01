
(function( w ){
	
	var X = { };
	
	/**
	 * @param method 表示请求方式，比如 GET 、POST 等
	 * @param url 表示请求的资源路径，比如 http://localhost:8080/ajax/check.do
	 * @param data 如果请求方式是 POST 方式，则使用 data 参数传入需要发送的数据
	 * @param fn 当请求后，响应结束时( readyState === DONE ) 对应的 处理函数
	 * @param async 指定本次请求是否是 异步请求，默认是异步请求
	 */
	X.ajax = function( method , url , data , fn , async ){
		
		// 1、创建 XMLHttpRequest 对象
		var $http = new XMLHttpRequest();
		if( typeof( async ) === "undefined" ) {
			async = true ;
		}
		var asynchronous = async ? true : false ;
		// 2、打开连接
		$http.open( method , url ,  asynchronous );
		
		// 3、设置对 readyState 的取值变化进行监听的监听函数
		$http.onreadystatechange = function(){
			if( $http.readyState === $http.DONE ){
				// 通过 call 调用 参数传入的 fn 函数 ，并为其传入 参数 ( 服务端返回的文本数据 ) 
				fn.call( null , $http.responseText );
			}
		}
		
		/*文件上传不要这行代码！！！！
		// 4、如果请求方式是 POST ，则需要设置 请求报头
	    if( method.toLowerCase().trim() === "post" ) {
	        $http.setRequestHeader( "content-type" , "multipart/form-data" );
	    }
	    */
	   
	    
	    // 5、发送请求
	    $http.send( data ) ; // data 是通过函数参数传入的需要发送的数据
	}
	
	
	w.X = X ;
	
})( window );
