1，准备好多张滚动图，如10张
2，在index.html 添加10张图路径，如下：
<div id="owl-demo" class="owl-carousel">
	<a class="item"><img src="js/cms1.png" alt=""></a>
	<a class="item"><img src="js/cms2.png" alt=""></a>
	<a class="item"><img src="js/cms5.png" alt=""></a>
	<a class="item"><img src="js/cms8.png" alt=""></a>
</div>

3，在 owl.theme.css中添加10个样式，如下
.owl-pagination .owl-page:nth-of-type(1) span:after{content:"01"}
.owl-pagination .owl-page:nth-of-type(2) span:after{content:"02"}
.owl-pagination .owl-page:nth-of-type(3) span:after{content:"03"}
.owl-pagination .owl-page:nth-of-type(4) span:after{content:"04"}
.owl-pagination .owl-page span{border:0}
.owl-pagination .owl-page:nth-of-type(1) span:after{font-size:16px;font-family:CYJXY;color:#000}
.owl-pagination .owl-page:nth-of-type(2) span:after{font-size:16px;font-family:CYJXY;color:#000}
.owl-pagination .owl-page:nth-of-type(3) span:after{font-size:16px;font-family:CYJXY;color:#000}
.owl-pagination .owl-page:nth-of-type(4) span:after{font-size:16px;font-family:CYJXY;color:#000}