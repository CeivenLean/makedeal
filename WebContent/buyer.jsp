<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="cn.shop.entity.*" %>
<%@ page import="cn.shop.dao.*" %>
<%@ page import="cn.shop.service.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="cn.shop.servlet.*" %>
<%@ page import="cn.shop.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	if(session.getAttribute("buyer")==null){
		response.sendRedirect(request.getContextPath()+"/login.jsp");
	}
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>买家主页</title>
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath }/images/mylogo.jpg">
<link rel="stylesheet" href="${pageContext.request.contextPath }/font-awesome/css/font-awesome.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/product.css">
<script src="${pageContext.request.contextPath }/js/jquery-2.1.1.min.js"></script>
<script type="text/javascript">
function goTop(min_height) {
    $(".goTop").click(
        function() {
            $('html,body').animate({
                scrollTop: 0
            }, 700);
        });
    //获取页面的最小高度，无传入值则默认为600像素
    min_height=min_height?min_height:400;
    //为窗口的scroll事件绑定处理函数
    $(window).scroll(function() {
        //获取窗口的滚动条的垂直位置
        var s = $(window).scrollTop();
        //当窗口的滚动条的垂直位置大于页面的最小高度时，让返回顶部元素渐现，否则渐隐
        if (s > min_height) {
            $(".goTop").fadeIn(100);
        } else {
            $(".goTop").fadeOut(200);
        }
    });
}
 
 
$(function() {
    goTop();
});
</script>
<style type="text/css">
body {background-color:#f4f4f4;}
	* {margin:0px 0px;padding:0px 0px;font-family:arial;} 
	.mynav-left {float:left;line-height:35px;font-family:arial;}
	.mynav-right {width:88%; margin:0px auto;background-color:cyan;}
	.mynav .right>li{float:right;list-style:none; margin-left:30px;font-size:10px;line-height:35px;font-family:arial;}
	.myhidden {display:none; }
	.abc li{list-style:none;font-size:12px;margin-bottom:-6px;font-family:arial;line-height:30px;height:30px;}
	.mynav .left{float:left;list-style:none;}
	.mynav a {text-decoration:none; color:black;}
	.mynav span:hover {display:block; background-color:#dedede;}
	.mynav {width:100%;height:35px; background-color:#f5f5f5;margin-bottom:20px;border:0;margin-top:-10px;}
	
	
.menu { text-decoration: none; font-size: 14px; width: 88%; height: 80%; margin: 20px auto; background-color: #ececec; }
.menu .menuTop { font-size:16px;text_align:center;background-color: #F10215; color: #fff; width: 160px; height: 40px; padding-left: 20px; line-height: 40px; cursor: pointer; }
.menu ul { width: 160px; background-color: #fff; border: 2px solid #F10215; box-sizing: border-box; position: relative; }
.menu ul li { list-style: none;height: 45px; padding-left: 8px; text-align: left; line-height: 45px; font-size: 13px; z-index: 2; }
.menu ul li a { color: #7070770; }
.menu ul li a:hover { color: red; text-decoration: underline; cursor: pointer; }
.menu ul li:hover { border: 1px solid #DDD; border-right: 0; background-image: none; }
.menu ul li:hover .submenu { display: block; }
.menu ul li:hover span { width: 30px; height: 43px; display: inline-block; background-color: #FFF; float: right; z-index: 100; position: relative; }
.menu ul li .submenu p {text-align:center;}
/* .menu ul li .submenu .subright div {background:url(${pageContext.request.contextPath }/images/goods/10.jpg)  no-repeat} */
.menu ul li .submenu { position: absolute; left: 154px; top: 0; width: 662px; height: 450px; border: 1px solid #DDD; box-shadow: 0 0 4px #DDD; -moz-box-shadow: 0 0 4px #DDD; -webkit-box-shadow: 0 0 4px #DDD; background-color: #FFF; z-index: 3; display: none; }
.menu ul li .submenu .subleft { margin-left: 0px; width: 500px; height: 450px; float: left; padding: 0px 5px ; }
.menu ul li .submenu .subleft dl { overflow: hidden; border-bottom: 1px solid #D1D1D1; padding: 1px 0; }
.menu ul li .submenu .subleft dl dt { float: left; height: 22px; line-height: 22px; margin-right: 10px; font-weight: bold; color: #707070; font-size: 12px; cursor: pointer; }
.menu ul li .submenu .subleft dl dd { }
.menu ul li .submenu .subleft dl dd a { display: block; float: left; border-left: 1px solid #707070; padding: 0 5px; color: #707070; height: 14px; line-height: 14px; margin: 3px 0; font-size: 11px; }
.menu ul li .submenu .subright { width: 160px; height: 450px; background-color: blue; float: left; }

.center-content{position:relative;width:88%;height:80%;}
.menuTop2{font-size:16px;background-color: #ff0215; color: #fff; width: 100%; height: 42px; padding-left: 20px; line-height: 42px; cursor: pointer;}
.menuTop2 span {display:inline-block;width:10%;text-align:center;}
.menuTop2 span:hover {background-color:#ff4815 }
.content {width:100%;height:454px;}
.content>div {float:left;}
.content>div div:hover{background-color:RGBA(0,0,0,0.5);}

.message {background-color:#fef;width:190px;height:452px;border: 1px solid #F10215;color:blue;s}
.message h4{text-align:center;}
.message p {font-size:13px;dispaly:inline-block;height:12%;width:90%;margin:0 auto;border-bottom:1px solid #F10215;}

.input-group input {border:none;}
.input-group button {border:none;}
.input-group button {color:white;background-color:red;}
.input-group button:hover {color:white;background-color:red;}
.input-group {border:1px solid red;}

.input-group input:focus {border:none;box-shadow:none;}

.goTop {
cursor:pointer;
    height: 70px;
    width: 70px;
    line-height:70px;
    text-align:center;
    background: red;
    border-radius: 50px;
    position: fixed;
    right: 20px;
    bottom: 30px;
    display: none;
}
 
.goTop span {
    color: #fff;
    text-align:center;
}
.goTop i{
	height: 70px;line-height:70px;font-size:20px;
}

.foot {margin:20px auto;width:88%;
font-family: 'Varela Round', sans-serif;
    min-height: 1px;
    padding-left: 15px;
    padding-right: 15px;}
.foot ul.legals {
height:20px;
text-align:center;
    list-style: none;
    color: #8c9398;
    font-size: 14px;
    margin: 5px auto;
    padding: 0px !important;
}
.foot ul {list-style: none;
text-align:center;
    color: #8c9398;
    font-size: 14px;
    margin: 5px auto;
    padding: 0px !important;}
.foot ul li {display: inline-block;
text-align:center;
    padding: 0px 20px;
    margin: 0px;}
.foot ul li:last-child {
text-align:center;
    border-right: none;
    border-right-width: initial;
    border-right-style: none;
    border-right-color: initial;
}
.foot .line {
    border-bottom: 1px solid #ababab;
    width: 170px;
    margin: 0 auto;
}
.foot ul.social li {
height:28px;
    padding: 0px 5px;
    font-size: 20px !important;
}
.foot ul.social {
height:28px;
line-height:28px;
}
.foot ul.legals li {
    display: inline-block;
    padding: 0px 20px;
    margin: 0px;
}
.foot a {
text-align:center;
    -webkit-font-smoothing: antialiased;
    text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.004);
    color: #353535;
}
.foot a:hover, a:focus {
    color: #ffa200;
    text-decoration: none;
}
.foot a:hover {
    outline: 0;
}
.foot ul.legals li:last-child {
    border-right: none;
}
.foot ul.social li {
text-align:center;
    padding: 0px 5px;
    font-size: 20px !important;
}
.foot .copy {
    font-size: 10px;
    text-align: center;
    color: #404142;
    word-spacing: 1px;
    line-height: 25px;
    height:25px;
    text-transform: uppercase;
}

</style>
</head>
<script type="text/javascript">
	function show(){
		document.querySelector(".myhidden").style.display="block";
	}
	function myhidden(){
		document.querySelector(".myhidden").style.display="none";
	}
	
	function userdelete(){
		if(window.confirm("注意，此操作不可取消！！请确认是否删除账户")){
			document.querySelector(".mydelete").href="${pageContext.request.contextPath }/user/delete";
		}
	}
	
	function inputvalue(){
		var input = document.querySelector("input[name='search']");
		input.style.color = "#8e8e8e";
		input.style.fontSize = "6px";
		input.value = "${sessionScope.value}";
	}
	function inputclear(){
		var input = document.querySelector("input[name='search']");
		input.style.color = "";
		input.style.fontSize = "";
		input.value = "";
	}
	function addshoppingcart(e,goodId){
		
		var xhr = new XMLHttpRequest();
		var method = "post";
		var url = "${pageContext.request.contextPath }/user/shoppingcart?goodId="+goodId+"&goodCount=1";
		xhr.open(method,url);
		xhr.onreadystatechange = function(){
			if(xhr.readyState===xhr.DONE){
				if(xhr.status==200){
					var result = xhr.responseText;
					if(result=="1"){
						e.innerHTML = "添加成功" ;
					}else{
						e.innerHTML = "请勿重复添加";
					}
				}
			}
		}
		xhr.setRequestHeader("content-type","application/x-www-form-urlencoded");
		xhr.send();
		
	}
	
</script>
<script src="${pageContext.request.contextPath }/js/jquery.js"></script>

<script type="text/javascript">

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

	
	$(function(){
		$('.sort').mouseenter(function(){
			var j_centercontent= $(".center-content");
			var centercontent = j_centercontent[0];
			console.log(centercontent);
			centercontent.style.hidden = "hidden";
			var j_li = $(this);
			var random1 = Math.floor(Math.random()*10+1);
			var random2 = Math.floor(Math.random()*10+1);
			j_li.append("<div class=\"submenu\"><div class=\"subleft\"></div><div class=\"subright\" style=\"background-color: antiquewhite\"><p>猜您喜欢</p><div style=\"margin:30px auto;height:35%;width:70%;\"><img src=\"${pageContext.request.contextPath }/images/goods/"+random1+".jpg\" width=\"100%\" height=\"100%\"></div><div style=\"margin:30px auto;height:35%;width:70%;\"><img src=\"${pageContext.request.contextPath }/images/goods/"+random2+".jpg\" width=\"100%\" height=\"100%\"></div></div></div>");
			/* var li = j_li[0]; */
			var li = j_li.get(0);
			var a = li.firstElementChild;
			var key = a.innerHTML;
			var subleft = li.lastElementChild.firstElementChild;
			var index = pres.indexOf(key);
			var sec = cities[index];
			for(var i=0;i<sec.length;i++){
				var dl = document.createElement("dl");
				var dt = document.createElement("dt");
				dt.innerHTML = sec[i];
				dl.appendChild(dt);
				var third = areas[index][i];
 				for(var j=0;j<third.length;j++){
 					var dd = document.createElement("dd");
 					dd.innerHTML = "<a href='${pageContext.request.contextPath }/good/listBySort?sort="+third[j]+"'>"+third[j]+"</a>";
 					dl.appendChild(dd);
 				}
 				subleft.appendChild(dl);
				
			}
			
		});
	});
	
	
</script>

<body onload="inputvalue()">
	<div id="mytop" class="mynav">
		<div class="mynav-right">
			<div class="mynav-left">
				<a href="${pageContext.request.contextPath }/buyer.jsp">欢迎，${buyer.name }！</a>
			</div>
			<ul class="right">
				<li><span><a href="http://sighttp.qq.com/msgrd?v=1&uin=1584592950">联系客服</a></span></li>
				<li onMouseOver="show()" onMouseOut="myhidden()"><span><a href="#"><i class="fa fa-user-o" aria-hidden="true"   style="color:#FF6905;font-size:14px;"></i>&nbsp;&nbsp;个人中心</a>&nbsp;&nbsp;&nbsp;<i class="fa fa-angle-down" aria-hidden="true"></span></i>
					<div class="myhidden">
					<ul class="abc list-unstyled">
						<li><span><a href="${pageContext.request.contextPath }/complete.jsp">修改个人信息</a></span></li>
						<li><span><a class="mydelete" onClick="userdelete()">删除此账户</a></span></li>
						<li><span><a href="${pageContext.request.contextPath }/user/logout">退出登录</a></span></li>
					</ul>
					</div>
				</li>
				<li><span><a href="${pageContext.request.contextPath }/user/listShoppingCart"><i class="fa fa-shopping-cart" aria-hidden="true" style="color:#FF6905;font-size:14px;"></i>&nbsp;&nbsp;购物车</a>&nbsp;&nbsp;&nbsp;<i class="fa fa-angle-down" aria-hidden="true"></i></span></li>
				<li><span><a href="${pageContext.request.contextPath }/user/listOrder"><i class="fa fa-history" aria-hidden="true"  style="color:#FF6905;font-size:14px;"></i>&nbsp;&nbsp;我的订单</a>&nbsp;&nbsp;&nbsp;<i class="fa fa-angle-down" aria-hidden="true"></i></span></li>
			</ul>
		</div>
	</div>
	
	<div class="container-fluid">
	    <form action="${pageContext.request.contextPath }/good/list" method="post">
		    <div  class="row">
			  <div  class="col-lg-6 col-lg-offset-3">
			    <div class="input-group">
			      <input type="text" class="form-control" name="search"  onfocus="inputclear()" placeholder="请输入关键字..">
			      <span class="input-group-btn">
			        <button class="btn btn-default" type="submit" value="搜索">搜索</button>
			      </span>
			    </div>
			    <div style="margin-top:4px;">大家都在搜：&nbsp;
			    	<a href="${pageContext.request.contextPath }/good/list?search=坚果">坚果</a>&nbsp;
			    	<a href="${pageContext.request.contextPath }/good/list?search=袜子">袜子</a>&nbsp;
			    	<a href="${pageContext.request.contextPath }/good/list?search=鞋子">鞋子</a>&nbsp;
			   
			    </div>
			  </div>
			</div>
	    </form>
	</div>
	<div class="menu">
	<div class="center-content">
		<div class="menuTop">全部商品分类&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-angle-down"></i></div>
		<div style="margin-right:-144px;margin-top:-40px;float:right;width:98.5%;height:504px;">
			<div class="menuTop2">
					<span style="margin-left:-20px;">最新上架</span>
					<span>热销推荐</span>
					<span>九块九包邮</span>
					<span>电视</span>
					<span>手机</span>
					<span>教材</span>
					<span>笔记本</span>
					<span>猜你喜欢</span>
			</div>
			<div class="content">
				<div style="position:relative">
					<div onclick="prePic()" style="cursor:pointer;color:white;border-radius:20px;font-size:30px;background-color:RGBA(0,0,0,0.2);width:40px;height:40px;line-height:40px;text-align:center;position:absolute;margin-top:200px;margin-left:16px;border">&laquo;</div>
					<div onclick="nextPic()" style="cursor:pointer;color:white;border-radius:20px;font-size:30px;background-color:RGBA(0,0,0,0.2);width:40px;height:40px;line-height:40px;text-align:center;position:absolute;margin-top:200px;margin-left:786px">&raquo;</div>
					<img id="banner" src="//img.alicdn.com/tfs/TB14smleuOSBuNjy0FdXXbDnVXa-520-280.jpg_q90_.webp" height="452px" alt="">
					<!-- <img border="0" src="https://aecpm.alicdn.com/simba/img/TB1JNHwKFXXXXafXVXXSutbFXXX.jpg" width="520px" height="280px" data-spm-anchor-id="a21bo.2017.201862.i2.5af911d9hYTQ3S">
					<img border="0" src="https://aecpm.alicdn.com/simba/img/TB183NQapLM8KJjSZFBSutJHVXa.jpg" width="520px" height="280px"> -->
				</div>
				<div class="message">
					<h4>最新公告</h4><hr>
					<p>ceiven新上架了一款商品，快来看看吧</p>
					<p>9527对商品XXXXXXX发了评论，快来看看吧</p>
					<p>管理员：请各位 做好财产保护措施，谨防骗子！！！</p>
					<p>管理员：请各位 做好财产保护措施，谨防骗子！！！</p>
					<p>管理员：请各位 做好财产保护措施，谨防骗子！！！</p>
					<p>管理员：请各位 做好财产保护措施，谨防骗子！！！</p>
					
				</div>
			</div>
			<script>
				function prePic(){
					var banner = document.querySelector("#banner");
					banner.src = "https://aecpm.alicdn.com/simba/img/TB1JNHwKFXXXXafXVXXSutbFXXX.jpg";
				}
				function nextPic(){
					var banner = document.querySelector("#banner");
					banner.src = "https://aecpm.alicdn.com/simba/img/TB183NQapLM8KJjSZFBSutJHVXa.jpg";
				}
			</script>
		
		</div>
		
	    <ul>
	      <li class="sort"> <a herf="${pageContext.request.contextPath }/good/listBySort?sort=家用电器">家用电器</a> <span></span></li>
	      <li class="sort"> <a herf="${pageContext.request.contextPath }/good/listBySort?sort=手机/运营商/数码">手机/运营商/数码</a> <span></span></li>
	      <li class="sort"> <a herf="${pageContext.request.contextPath }/good/listBySort?sort=电脑/办公">电脑/办公</a> <span></span></li>
	      <li class="sort"> <a herf="${pageContext.request.contextPath }/good/listBySort?sort=家居/家具/家装/厨具">家居/家具/家装/厨具</a> <span></span></li>
	      <li class="sort"> <a herf="${pageContext.request.contextPath }/good/listBySort?sort=男装/女装/童装/内衣">男装/女装/童装/内衣</a> <span></span></li>
	      <li class="sort"> <a herf="${pageContext.request.contextPath }/good/listBySort?sort=美妆个护">美妆个护</a> <span></span></li>
	      <li class="sort"> <a herf="${pageContext.request.contextPath }/good/listBySort?sort=女鞋/箱包/钟表/珠宝">女鞋/箱包/钟表/珠宝</a> <span></span></li>
	      <li class="sort"> <a herf="${pageContext.request.contextPath }/good/listBySort?sort=男鞋/运动/户外">男鞋/运动/户外</a> <span></span></li>
	      <li class="sort"> <a herf="${pageContext.request.contextPath }/good/listBySort?sort=食品/酒类/生鲜">食品/酒类/生鲜</a> <span></span></li>
	      <li class="sort"> <a herf="${pageContext.request.contextPath }/good/listBySort?sort=图书/音像/电子书">图书/音像/电子书</a> <span></span></li>
	    </ul>
	    
	   
	   </div>
	</div>

	<div class="product-list">
	
		<div class="product-title">
            <p>最新上架</p>
        </div>

        <div style="margin-left:4%;">
        <ul>
            <c:forEach var="map" items="${goodlistmap}" >
                <li class="cell-3">
                    <div class="inner"><a href="${pageContext.request.contextPath}/good/detail?id=${map.value.goodId}">
                        <p class="pic">
                            
                                <img src="${pageContext.request.contextPath}/images/goods/${map.value.goodId}.jpg" height="200px" width="200px" border="0" alt="商品图片">
                            
                        </p>
                        <p class="pro_name">
                            ${map.value.goodTitle }
                        <p/></a>
                        <h5 class="pro_sellingPrice">商家：${map.value.sellerName }</h5>
                        <h6 class="pro_memberPrice">单价：<span style="color:red;font-size:20px;">${map.value.goodPrice}</span><span onclick="addshoppingcart(this,${map.value.goodId})" style="cursor:pointer;height:30px;line-height:30px;padding:2px 4px;float:right;border:1px solid red;background-color:red;color:#fff"><i class="fa fa-shopping-cart" aria-hidden="true" style="color:#FFF;font-size:20px;"></i>加入购物车</span> </h6>
                    </div>
                </li>

            </c:forEach>
        </ul>
        </div>
        
	</div>
	<div style="margin-top:700px;width:100%;height:100px;"></div>
	<hr>
	
	<div class="product-list">
	
		<div class="product-title">
            <p>热销商品</p>
        </div>

        <div style="margin-left:4%;">
        <ul>
            <c:forEach var="map" items="${goodlistmap}" >
                <li class="cell-3">
                    <div class="inner"><a href="${pageContext.request.contextPath}/good/detail?id=${map.value.goodId}">
                        <p class="pic">
                            
                                <img src="${pageContext.request.contextPath}/images/goods/${map.value.goodId}.jpg" height="200px" width="200px" border="0" alt="商品图片">
                            
                        </p>
                        <p class="pro_name">
                            ${map.value.goodTitle }
                        <p/></a>
                        <h5 class="pro_sellingPrice">商家：${map.value.sellerName }</h5>
                        <h6 class="pro_memberPrice">单价：<span style="color:red;font-size:20px;">${map.value.goodPrice}</span><span onclick="addshoppingcart(this,${map.value.goodId})" style="cursor:pointer;height:30px;line-height:30px;padding:2px 4px;float:right;border:1px solid red;background-color:red;color:#fff"><i class="fa fa-shopping-cart" aria-hidden="true" style="color:#FFF;font-size:20px;"></i>加入购物车</span> </h6>
                    </div>
                </li>

            </c:forEach>
        </ul>
        </div>
        
	</div>
	
	
	<%--取消，改用jquery动态实现 <div style="display:block;width:70px; height:70px;line-height:70px;position:fixed;right: 20px;bottom: 30px; "><a href="#mytop"><img width="70px" height="70px" alt="返回顶部" src="${pageContext.request.contextPath}/images/backTop.jpg"></a></div> --%>
	<div class="goTop">
    <span><i class="fa fa-arrow-up"></i></span>
	</div>
	
	<div style="margin-top:900px;margin-bottom:60px;" class="foot">
		<ul class="legals">
			<li>
				<a href="https://github.com/CeivenLean/makedeal" target="blank" target="_blank">关于</a>
			</li>
			<li>
				<a href="http://blog.sina.com.cn/u/1769758704" target="blank" target="_blank">博客</a>
			</li>
			<li>
				<a href="http://localhost:8080/shop/" target="_blank">网站</a>
			</li>
		</ul>
		<div class="line"></div>
		<ul class="legals social">
			<li>
				<a href="javascropt:void(0)" title="腾讯QQ"><i class="fa fa-qq"></i></a>
			</li>
			<li>
				<a href="javascropt:void(0)" title="微信"><i class="fa fa-weixin"></i></a>
			</li>
			<li>
				<a href="https://weibo.com/u/1769758704" target="blank" title="微博"><i class="fa fa-weibo"></i></a>
			</li>
			<li>
				<a href="mailto:ceiven@foxmail.com" title="商务合作"><i class="fa fa-envelope-o"></i></a>
			</li>
		</ul>
		<p class="copy">© 2018 · CeivenLean · All Rights Reserved</p>
	</div>
	
</body>
</html>