    /**
        疑问：JS的调试问题？
     
        疑问：require是怎样创建一个与实参同名的变量的？
            var global = this; global[clsName] = {...};
            相当于this.clsName = {...}，那么这个clsName变量就是document作用域的，则可以直接采用clsName访问。
     
        疑问：为什么对实例的属性修改都是采用.xxx()方法的方式？
            因为，为了能用正则把.xxx()方法调用替换成.__c(xxx)的调用，以及方便回调到OC时能采用Runtime运行时selector调用。
     
        疑问：Object.defineProperty(x,y,z)？
            扩展属性，且可设置descriptor
     
        疑问：Object.prototype 原型链
            参看：http://hi-gp.iteye.com/blog/1460980
     
        疑问：定义一个获取任意方法参数集合的通用方法?
            va_list(32位), forwardInvocation(64位)
     
        疑问：bind方法
     
     */

    var global = this;

    ////////////////////////////////////////////////////////////////////////////////////////
    //类名引用///////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////
    //单个引用类名
    var _require = function (clsName) {
        if (!global[clsName]) {
            global[clsName] = {
                __clsName : clsName
            };
        }
        return global[clsName];
    };

    //批量引用类名
    global.require = function(clsName) {
        var lastRequire;
        clsName.split(",").forEach(function(clsName) {
                                        lastRequire = _require(clsName.trim());
                                   });
        return lastRequire;
    };

    ////////////////////////////////////////////////////////////////////////////////////////
    //JS消息转发到OC的函数/////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////

    var _methodFunc = function(instance, clsName, methodName, args, isSuper, isPerformSelector) {
      var selectorName = methodName;
      if (!isPerformSelector) {
//          methodName = todo...
      }
    };

    Object.defineProperty(Object.prototype, "__c", {value : function(methodName) {
      var self = this;
      return function() {
        var args = Array.prototype.slice.call(arguments);
        return _methodFunc(self.__obj, self.clsName, methodName, args, self.__isSuper);
      };
    }, configurable : false,/*不可被修改、删除*/ enumerable : false/*不可被for/in遍历*/});



    //--------------------
    var callOC = function(v) {
        __c(v);
    };

    require("UIView, UIViewController")
    var view = UIView.alloc().init();
    view.setBackgroundColor(require("UIColor").redColor());
    view.setAlpha(0.5);
    //callOC(view);