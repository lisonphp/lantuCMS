// new WOW().init();
var wow = new WOW({
    offset: 120,
    mobile: true,
    live: true
});
wow.init();

$('#header .hamburger-box').click(function(){ 
    if($(this).hasClass('is-active')){
        $(this).removeClass('is-active');
        $('#header .one_nav').slideUp(300);
    }else{
        $(this).addClass('is-active');
        $('#header .one_nav').slideDown(300);
    }
})
// $('#header .one_list').click(function(){
//     // console.log($(this).children('.one_list_a').hasClass('one_list_a_x'))
//     if($(this).children('.one_list_a').hasClass('one_list_a_x')){
//         if(document.body.clientWidth > 1200){
//             if($(this).hasClass('show')){
//                 $(this).removeClass('show');
//             }else{
//                 $(this).addClass('show').siblings().removeClass('show');
//             }
//         }else{
//             if($(this).hasClass('show2')){
//                 $(this).removeClass('show2');
//             }else{
//                 $(this).addClass('show2').siblings().removeClass('show2');
//             }
//         }
//     };
// })
if(document.body.clientWidth < 1200){
    $('.one_list_a_x').click(function(){
        $(this).next().slideToggle();
        $(this).parent().siblings().find('.two_nav').slideUp();
    })
    $('.two_list_a_ti').click(function(){
        if($(this).parent().attr('style') == 'height: auto;'){
            $(this).parent().css('height','55px');
        }else{
            $(this).parent().css('height','auto');
            $(this).parent().siblings().css('height','55px');
        }
    })
}else{
    $('.one_list_a_x').click(function(){
        console.log($(this).parent())
        if($(this).parent().hasClass('show')){
            $(this).parent().removeClass('show');
        }else{
            $(this).parent().addClass('show').siblings().removeClass('show');
        }
    })
}
document.body.addEventListener('touchstart', function(){ });
if(document.body.clientWidth < 640){
    $('#header .home_banner .swiper-slide').css('height',window.innerHeight - document.querySelector('.header_nav').clientHeight + 'px');
}
window.onresize = function(){
    if(document.body.clientWidth < 640){
        $('#header .home_banner .swiper-slide').css('height',window.innerHeight - document.querySelector('.header_nav').clientHeight + 'px');
    }
}


/*留言版下拉框*/
$('select').niceSelect();

/*tab切换*/
$('.gg-nav').on('click','span',function(){
    if(!$(this).hasClass('hover')){
        $(this).addClass('hover').siblings().removeClass('hover');
        $(this).parent().next().find('.medium-advantage-list').eq($(this).index()).fadeIn(300).siblings().fadeOut(300);
        //$(this).parent().next().find('.medium-advantage-list').eq($(this).index()).show().siblings().hide();
    }
})

/*浏览器判断不支持ie9及以下*/
var DEFAULT_VERSION = 9.0;  
var ua = navigator.userAgent.toLowerCase();  
var isIE = ua.indexOf("msie")>-1;  
var safariVersion;  
if(isIE){  
safariVersion =  ua.match(/msie ([\d.]+)/)[1];  
}  
if(safariVersion <= DEFAULT_VERSION ){  
    alert('系统检测到您正在使用ie9及以下内核的浏览器，不能实现完美体验，请更换或升级浏览器访问！')
}; 