(function() {
  this.tabsInit = function(tabClassName, contentClassName) {
    var clickTab, tab, tabContents, tabs, _i, _len, _results;
    if (tabClassName == null) {
      tabClassName = 'tab';
    }
    if (contentClassName == null) {
      contentClassName = 'tabContent';
    }
    tabs = document.querySelectorAll('.' + tabClassName);
    tabContents = document.querySelectorAll('.' + contentClassName);
    clickTab = function(tab) {
      var cName, re, t, tabName, tc, tci, _i, _j, _k, _len, _len1, _len2, _ref, _results;
      for (_i = 0, _len = tabs.length; _i < _len; _i++) {
        t = tabs[_i];
        t.classList.remove("active");
      }
      tab.classList.add("active");
      tabName = "";
      re = new RegExp(tabClassName + "\\d");
      _ref = tab.classList;
      for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
        cName = _ref[_j];
        if (cName.match(re) !== null) {
          tabName = cName;
          break;
        }
      }
      _results = [];
      for (_k = 0, _len2 = tabContents.length; _k < _len2; _k++) {
        tc = tabContents[_k];
        tc.classList.remove("active");
        tc = document.querySelectorAll('.' + contentClassName + '.' + tabName);
        _results.push((function() {
          var _l, _len3, _results1;
          _results1 = [];
          for (_l = 0, _len3 = tc.length; _l < _len3; _l++) {
            tci = tc[_l];
            _results1.push(tci.classList.add("active"));
          }
          return _results1;
        })());
      }
      return _results;
    };
    _results = [];
    for (_i = 0, _len = tabs.length; _i < _len; _i++) {
      tab = tabs[_i];
      _results.push(tab.onclick = function() {
        return clickTab(this);
      });
    }
    return _results;
  };

  this.triggersInit = function(trigClassname, trigContentName) {
    var clickTrig, t, trigged, trigs, _i, _len, _results;
    if (trigClassname == null) {
      trigClassname = "trigger";
    }
    if (trigContentName == null) {
      trigContentName = "trigged";
    }
    trigs = document.querySelectorAll("." + trigClassname);
    trigged = document.querySelectorAll("." + trigContentName);
    clickTrig = function(trig) {
      var cName, re, td, trigName, trigState, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _results;
      trigName = "";
      trigState = "off";
      re = new RegExp(trigClassname + "\\d");
      _ref = trig.classList;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        cName = _ref[_i];
        if (cName.match(re) !== null) {
          trigName = cName;
        }
        if (cName === "off" || cName === "on") {
          trigState = cName;
        }
      }
      for (_j = 0, _len1 = trigged.length; _j < _len1; _j++) {
        td = trigged[_j];
        td.classList.remove("active");
      }
      if (trigState === "on") {
        trig.classList.remove("on");
        trig.classList.add("off");
        trigState = "off";
      } else {
        trig.classList.remove("off");
        trig.classList.add("on");
        trigState = "on";
      }
      _ref1 = document.querySelectorAll("." + trigContentName);
      _results = [];
      for (_k = 0, _len2 = _ref1.length; _k < _len2; _k++) {
        td = _ref1[_k];
        if (td.classList.contains(trigName)) {
          if (trigState === "on") {
            _results.push(td.classList.add("active"));
          } else {
            _results.push(td.classList.remove("active"));
          }
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };
    _results = [];
    for (_i = 0, _len = trigs.length; _i < _len; _i++) {
      t = trigs[_i];
      _results.push(t.onclick = function() {
        return clickTrig(this);
      });
    }
    return _results;
  };

}).call(this);
