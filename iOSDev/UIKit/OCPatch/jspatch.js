//疑问1：JS的调试问题
//疑问2：如何通过require创建一个与实参同名的变量

var global = this;
var _require = function (clsName) {
    if (!global[clsName]) {
        global[clsName] = {
            __isCls : 1,
            __clsName : clsName
        };
    }
    return global[clsName];
};

global.require = function(clsName) {
    var lastRequire;
    clsName.split(",").forEach(function(clsName) {
                               lastRequire = _require(clsName.trim());
                               });
    
    return lastRequire;
};

//--------------------
var callOC = function(v) {
    __c(v);
};

require("UIView")
callOC(UIView);