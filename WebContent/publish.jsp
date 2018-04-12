<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="cn.shop.entity.*" %>
<%@ page import="cn.shop.dao.*" %>
<%@ page import="cn.shop.service.*" %>

<%
	if(session.getAttribute("seller")==null){
		response.sendRedirect(request.getContextPath()+"/login.jsp");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${seller.name }发布商品</title>
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath }/images/favicon.ico">
<link rel="stylesheet" href="${pageContext.request.contextPath }/font-awesome/css/font-awesome.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/bootstrap/css/bootstrap.css">
<style type="text/css">
	.mycontainer{margin:20px auto;}
	* {margin:0px 0px;padding:0px 0px;font-family:arial;} 
	.mynav-left {float:left;line-height:35px;font-family:arial;}
	.mynav-right {width:88%; margin:0px auto;background-color:cyan;}
	.mynav .right>li{float:right;list-style:none; margin-left:30px;font-size:10px;line-height:35px;font-family:arial;}
	.myhidden {display:none;}
	.abc li{list-style:none;font-size:8px;margin-bottom:-6px;font-family:arial;}
	.mynav .left{float:left;list-style:none;}
	.mynav a {text-decoration:none; color:black;}
	.mynav span:hover {display:block; background-color:#dedede;}
	.mynav {width:100%;height:35px; background-color:#f5f5f5;margin-bottom:20px;border:0;margin-top:-10px;}
	.upload {cursor: pointer;}
</style>
<script type="text/javascript">
	
</script>
</head>
<script type="text/javascript">
	(function(w){
		var $ = {};
		
		$.show = function(){
			document.querySelector(".myhidden").style.display="block";
		}
		$.myhidden = function(){
			document.querySelector(".myhidden").style.display="none";
		}
		$.userdelete = function(){
			if(window.confirm("注意，此操作不可取消！！请确认是否删除账户")){
				document.querySelector(".mydelete").href="${pageContext.request.contextPath }/user/delete";
			}
		}
		
		$.upload = function(e){
			var ele = e.previousElementSibling;
			if(ele.type=="file"){
				e.parentNode.removeChild(ele);
			}
			var input = document.createElement("input");
			input.type = "file";
			input.name = "upload";
			input.style.display = "none";
			
			e.parentNode.insertBefore(input,e);
			input.click();
			
			input.onchange = function(){
				var file = input.files[0];
				e.value = file.name;
			}
			
		}
		
		
		
		
		
		w.$ = $;
		
	})(window);
	
	
</script>

<body>
	<div class="mynav">
		<div class="mynav-right">
			<div class="mynav-left">
				<a href="${pageContext.request.contextPath }/seller.jsp">欢迎，${seller.name }！</a>
			</div>
			<ul class="right">
				<li><span><a href="#">联系客服</a></span></li>
				<li onMouseOver="$.show()" onMouseOut="$.myhidden()"><span><a href="#"><i class="fa fa-user-o" aria-hidden="true"   style="color:#FF6905;font-size:14px;"></i>&nbsp;&nbsp;个人中心</a>&nbsp;&nbsp;&nbsp;<i class="fa fa-angle-down" aria-hidden="true"></span></i>
					<div class="myhidden">
					<ul class="abc list-unstyled">
						<li><span><a href="${pageContext.request.contextPath }/complete.jsp">修改个人信息</a></span></li>
						<li><span><a class="mydelete" onClick="$.userdelete()">删除此账户</a></span></li>
						<li><span><a href="${pageContext.request.contextPath }/user/logout">退出登录</a></span></li>
					</ul>
					</div>
				</li>
				<li><span><a href="${pageContext.request.contextPath }/seller/goodList"><i class="fa fa-user" aria-hidden="true" style="color:#FF6905;font-size:14px;"></i>&nbsp;&nbsp;在售商品</a>&nbsp;&nbsp;&nbsp;<i class="fa fa-angle-down" aria-hidden="true"></i></span></li>
				<li><span><a href="${pageContext.request.contextPath }/seller/orderList"><i class="fa fa-history" aria-hidden="true"  style="color:#FF6905;font-size:14px;"></i>&nbsp;&nbsp;我的订单</a>&nbsp;&nbsp;&nbsp;<i class="fa fa-angle-down" aria-hidden="true"></i></span></li>
			</ul>
		</div>
	</div>	

	<div class="mycontainer">
		<form action="<%=request.getContextPath()%>/good/publish" method="post" enctype="multipart/form-data">
		
		  <div class="form-group col-sm-6 col-sm-offset-3">
		    <label for="goodTitle">输入商品名称</label>
		    <input type="text" class="form-control input" name="goodTitle" placeholder="">
		  </div>
		  
		  <div class="form-group col-sm-6 col-sm-offset-3">
		    <label for="goodSort">为商品添加分类</label>
			  <select name="sort1" style="width: 100px;" id="pre" onchange="chg(this);">
			   <option value="-1">请选择</option>
			  </select>
			  <select name="sort2" style="width: 100px;" id="city" onchange="chg2(this)" ;></select>
			  <select name="sort3" style="width: 100px;" id="area"></select>
		  </div>
		  
		  <div class="form-group col-sm-6 col-sm-offset-3">
		    <label for="goodDesc">输入商品描述</label>
		    <textarea class="form-control input-" rows="6" name="goodDesc"></textarea>
		  </div>
		  <div class="form-group col-sm-6 col-sm-offset-3">
		    <label for="goodPrice">输入商品单价</label>
		    <input type="text" class="form-control input" name="goodPrice" placeholder="">
		  </div>
		  <div class="form-group col-sm-6 col-sm-offset-3">
		    <label for="goodPrice">为商品添加图片</label>
		    <input type="text" class="form-control upload" onclick="$.upload(this)" placeholder="点击选择图片...">
		  </div>
		  <div class="form-group col-sm-6 col-sm-offset-3">
		  <button type="submit" class="btn btn-info btn-lg btn-block" >发布</button>
		  </div>
		</form>
	</div>

	
</body>
<script>

//声明省
var pres = [ "家用电器", "手机/运营商/数码", "电脑/办公", "家居/家具/家装/厨具", "男装/女装/童装/内衣",
		"美妆个护", "女鞋/箱包/钟表/珠宝", "男鞋/运动/户外", "食品/酒类/生鲜", "图书/音像/电子书" ]; //直接声明Array
//声明市
var cities = [

		[ "电视", "空调", "洗衣机", "冰箱", "厨卫大电", "厨卫小电", "生活电器", "个护健康"],
		[ "手机通讯", "手机配件", "摄影摄像", "电子教育" ],
		[ "电脑整机", "电脑配件", "外设产品", "网络产品", "办公设备" ],
		[ "厨具", "家纺", "生活日用", "灯具", "家具", "家装主材", "厨房卫浴", "五金电工" ],
		[ "女装", "男装", "内衣", "配饰", "童装", "童鞋" ],
		[ "面部护肤", "洗发护发", "身体护理", "口腔护理", "女性护理", "香水彩妆", "清洁用品" ],

		[ "时尚女鞋", "潮流女包", "精品男包", "功能箱包", "钟表", "珠宝首饰" ],
		[ "流行男鞋", "运动鞋包", "运动服饰", "健身训练", "骑行运动", "体育用品",  "户外装备",
				"垂钓用品"],
		[ "新鲜水果", "蔬菜蛋品", "精选肉类", "海鲜水产", "冷饮冻食", "中外名酒", "休闲食品", "茗茶", "饮料冲调"],
		[ "教育", "文艺", "经管励志", "人文社科", "生活", "科技", "刊/原版", "音像" ] ];

var areas = [

		//1
		[
				[ "曲面电视", "超薄电视", "HDR电视", "OLED电视", "4K超清电视", "人工智能电视",
						"电视配件" ],
				[ "壁挂式空调", "柜式空调", "中央空调", "空调配件" ],
				[ "滚筒洗衣机", "洗烘一体机", "波轮洗衣机", "迷你洗衣机", "烘干机", "洗衣机配件" ],
				[ "多门", "对开门", "冷柜/冰吧", "酒柜", "冰箱配件" ],
				[ "油烟机", "燃气灶", "烟灶套装", "消毒柜", "洗碗机", "电热水器", "燃气热水器",
						"嵌入式厨电" ],
				[ "电烤箱", "电饭煲", "电压力锅", "咖啡机", "豆浆机", "料理机", "微波炉", "榨汁机" ],
				[ "吸尘器", "空气净化器", "电风扇", "扫地机器人", "蒸汽拖把/拖地机", "饮水机",
						"生活电器配件" ],
				[ "剃须刀", "口腔护理", "电吹风", "按摩器", "足浴盆足疗机", "美容器", "洁面仪",
						"其它健康电器" ]],

		//2
		[
				[ "手机", "对讲机", "手机维修" ],
				[ "手机壳", "贴膜", "手机存储卡", "数据线", "充电器", "耳机", "移动电源", "蓝牙耳机" ],
				[ "数码相机", "单反相机", "摄像机" ], [ "学生平板", "点读机", "复读机", "电子词典" ] ],

		//3
		[
				[ "笔记本", "游戏本", "平板电脑", "电脑配件", "台式机", "一体机" ],
				[ "显示器", "CPU", "主板", "显卡", "硬盘", "内存", "机箱", "电源", "散热器",
						"刻录机/光驱", "声卡/扩展卡", "装机配件", "SSD固态硬盘" ],
				[ "鼠标", "键盘", "键鼠套装", "网络仪表仪器", "U盘", "移动硬盘", "鼠标垫", "摄像头",
						"手写板" ],
				[ "路由器", "网络机顶盒", "交换机", "网络配件" ],
				[ "投影机", "投影配件", "多功能一体机", "打印机", "传真设备", "验钞/点钞机", "扫描设备",
						"复合机", "碎纸机", "考勤门禁", "收银机" ], ],

		//4
		[
				[ "烹饪锅具", "锅具套装", "保温杯", "刀剪菜板", "厨房配件", "水具酒具", "餐具",
						"保鲜盒" ],
				[ "床品套件", "被子", "枕芯", "蚊帐", "凉席", "毛巾", "浴巾", "地毯",
						"床垫/床褥/床单", "毯子", "抱枕", "靠垫", "帘/窗纱", "被套", "枕巾" ],
				[ "收纳用品", "雨伞", "雨具", "净化除味", "浴室用品", "洗晒/熨烫", "缝纫/针织用品",
						"清洁工具" ],
				[ "吸顶灯", "吊灯", "台灯", "装饰灯", "落地灯", "应急灯/手电", "节能灯" ],
				[ "卧室家具", "客厅家具", "餐厅家具", "书房家具", "阳台/户外", "办公家具" ],
				[ "瓷砖", "地板", "油漆", "涂料", "壁纸", "涂刷辅料" ],
				[ "水槽", "龙头", "淋浴", "花洒", "马桶", "浴霸" ],
				[ "锁具", "电动工具", "手动工具", "测量工具", "开关", "插座", "门铃", "监控",
						"配电箱/断路器" ] ],

		//5
		[
				[ "连衣裙", "T恤", "衬衫", "雪纺衫", "短外套", "卫衣", "针织衫", "风衣",
						"半身裙", "短裤", "旗袍/唐装", "休闲裤", "牛仔裤", "大码女装", "中老年女装" ],
				[ "T恤", "牛仔裤", "休闲裤", "衬衫", "短裤", "POLO衫", "羽绒服", "棉服",
						"夹克", "卫衣", "西服套装", "针织衫", "老年男装", "加绒裤" ],
				[ "文胸", "睡衣/家居服", "男士内裤", "女士内裤", "吊带/背心", "文胸套装", "情侣睡衣",
						"棉袜", "连裤袜/丝袜", "秋衣秋裤", "保暖内衣", "情趣内衣" ],
				[ "女士围巾/披肩", "男士丝巾/围巾", "光学镜架/镜片", "太阳镜", "防辐射眼镜", "老花镜",
						"领带/领结", "棒球帽", "贝雷帽", "鸭舌帽", "雨伞", "手套" ],
				[ "套装", "卫衣", "裤子", "外套/大衣", "毛衣/针织衫", "衬衫", "户外/运动服",
						"T恤", "裙子", "亲子装", "礼服/演出服", "羽绒服", "内衣" ],
				[ "运动鞋", "靴子", "帆布鞋", "皮鞋", "棉鞋", "凉鞋", "拖鞋" ] ],

		//6
		[
				[ "补水保湿", "卸妆", "洁面", "爽肤水", "乳液面霜", "精华", "眼霜", "防晒",
						"面膜", "剃须套装" ],
				[ "洗发", "护发", "染发", "造型", "假发", "美发", "工具套装" ],
				[ "沐浴", "润肤", "精油", "美胸套装" ],
				[ "牙膏/牙粉", "牙刷/牙线", "漱口水", "套装" ],
				[ "卫生巾", "卫生护垫", "私密护理", "脱毛膏" ],
				[ "BB霜", "化妆棉", "香水", "底妆", "眉笔", "睫毛膏", "眼线", "眼影", "唇膏",
						"美妆工具套装" ],
				[ "纸品", "湿巾", "衣物清洁", "清洁工具", "驱虫用品", "皮具护理" ] ],

		//7
		[
				[ "单鞋", "休闲鞋", "帆布鞋", "妈妈鞋", "布鞋/绣花鞋", "女靴", "马丁靴", "雪地靴",
						"高跟鞋", "凉鞋" ],
				[ "真皮包", "单肩包", "手提包", "斜挎包", "双肩包", "钱包", "手拿包" ],
				[ "男士钱包", "双肩包", "单肩/斜挎包", "商务公文包", "男士手包", "卡包", "名片夹" ],
				[ "拉杆箱", "拉杆包", "旅行包", "电脑包", "休闲运动包", "书包", "登山包",
						"腰包/胸包", "相机包" ],
				[ "日韩表", "欧美表", "德表", "儿童手表", "智能手表", "闹钟", "挂钟", "座钟",
						"钟表配件" ],
				[ "钻石", "翡翠", "玉石", "银饰", "水晶", "玛瑙", "铂金", "珍珠", "发饰" ] ],

		//8
		[
				[ "休闲鞋", "商务休闲鞋", "正装鞋", "帆布鞋", "凉鞋", "拖鞋", "雨鞋" ],
				[ "跑步鞋", "休闲鞋", "篮球鞋", "帆布鞋", "板鞋", "拖鞋", "运动包", "足球鞋" ],
				[ "T恤", "运动套装", "运动裤", "卫衣/套头衫", "夹克/风衣", "羽绒服", "运动配饰",
						"紧身衣", "背心" ],
				[ "跑步机", "动感单车", "健身车", "哑铃", "综合训练器", "划船机", "甩脂机", "倒立机",
						"拉力器/臂力器" ],
				[ "山地车", "公路车", "折叠车", "电动车", "电动滑板车", "自行车", "平衡车",
						"自行车配件" ],
				[ "乒乓球", "羽毛球", "篮球", "足球", "轮滑", "滑板", "网球", "高尔夫", "台球",
						"排球" ],
				[ "背包", "帐篷/垫子", "望远镜", "烧烤用具", "便携桌椅床", "户外配饰", "野餐用品",
						"睡袋/吊床", "户外照明" ],
				[ "钓竿", "鱼线", "浮漂", "鱼饵", "钓鱼配件", "渔具包", "钓箱", "钓椅", "鱼线轮",
						"钓鱼灯", "辅助装备" ]],

		//9
		[
				[ "苹果", "香蕉", "梨", "橙子", "奇异果/猕猴桃", "火龙果", "榴莲", "车厘子",
						"百香果", "草莓" ],
				[ "蛋品", "叶菜类", "根茎类", "葱", "姜", "蒜", "椒", "鲜菌菇", "茄",
						"果瓜类", "豆制品", "玉米", "山药", "地瓜/红薯" ],
				[ "猪肉", "牛肉", "羊肉", "鸡肉", "鸭肉", "冷鲜肉", "内脏类", "牛排", "牛腩",
						"鸡翅" ],
				[ "鱼类", "虾类", "蟹类", "海参", "鱿鱼/章鱼", "三文鱼", "鳕鱼", "海鲜", "干货" ],
				[ "水饺/馄饨", "汤圆/元宵", "面点", "烘焙", "奶酪/黄油", "方便速食", "冰淇淋",
						"冷藏饮料" ],
				[ "白酒", "葡萄酒", "洋酒", "啤酒", "黄酒/养生酒", "收藏酒/陈年老酒" ],

				[ "营养零食", "休闲零食", "坚果", "炒货", "肉干", "肉脯", "熟食", "蜜饯果",
						"干糖果/巧克力", "饼干", "蛋糕" ],
				[ "铁观音", "普洱", "龙井", "绿茶", "红茶", "乌龙茶", "花草茶", "花果茶", "黑茶",
						"白茶", "养生茶", "其他茶" ],
				[ "饮料", "牛奶", "酸奶", "饮用水", "咖啡/奶茶", "蜂蜜/柚子茶", "冲饮谷物",
						"成人奶粉" ]],

		//10
		[
				[ "教材", "中小学教辅", "考试", "外语学习", "字典词典", "课外读物", "英语四六级",
						"会计类考试", "国家公务员" ],
				[ "小说文学", "青春文学", "传记", "动漫", "艺术", "摄影", "书法", "音乐", "绘画" ],
				[ "管理", "金融与投资", "经济", "励志与成功", "市场营销", "股票", "智能经济" ],
				[ "历史", "心理学", "政治/军事", "国学/古籍", "哲学/宗教", "社会科学", "法律文化" ],
				[ "育儿/家教", "孕产/胎教", "健身保健", "旅游/地图", "美食", "时尚美妆", "家居",
						"手工DIY", "两性体育" ],
				[ "计算机与互联网", "科普", "建筑", "工业技术", "电子/通信", "医学", "科学与自然",
						"农林" ], [ "杂志/期刊", "英文原版书", "港台图书" ],
				[ "音乐", "影视", "教育音像", "游戏", "影视/动漫周边", "在线教育" ] ]

]


   //设置一个省的公共下标

  var pIndex = -1;
  var preEle = document.getElementById("pre");
  var cityEle = document.getElementById("city");
  var areaEle = document.getElementById("area");
   //先设置省的值

  for (var i = 0; i < pres.length; i++) {
   //声明option.<option value="pres[i]">Pres[i]</option>
   var op = new Option(pres[i], i);
   //添加
   preEle.options.add(op);
  }

  function chg(obj) {
   if (obj.value == -1) {
    cityEle.options.length = 0;
    areaEle.options.length = 0;
   }

   //获取值
   var val = obj.value;
   pIndex = obj.value;
   //获取ctiry
   var cs = cities[val];
   //获取默认区
   var as = areas[val][0];
   //先清空市
   cityEle.options.length = 0;
   areaEle.options.length = 0;
   for (var i = 0; i < cs.length; i++) {
    var op = new Option(cs[i], i);
    cityEle.options.add(op);

   }

   for (var i = 0; i < as.length; i++) {
    var op = new Option(as[i], i);
    areaEle.options.add(op);

   }

  }

  function chg2(obj) {
   var val = obj.selectedIndex;
   var as = areas[pIndex][val];
   areaEle.options.length = 0;
   for (var i = 0; i < as.length; i++) {

    var op = new Option(as[i], i);

    areaEle.options.add(op);

   }

  }

 </script>
</html>