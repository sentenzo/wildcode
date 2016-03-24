@tabsInit = (tabClassName = 'tab', contentClassName = 'tabContent') ->
    tabs = document.querySelectorAll('.' + tabClassName)
    tabContents = document.querySelectorAll('.' + contentClassName)
    clickTab = (tab) ->
        t.classList.remove("active") for t in tabs
        tab.classList.add("active")
        tabName = ""
        re = new RegExp(tabClassName + "\\d");
        for cName in tab.classList
            if cName.match(re) != null
                tabName = cName
                break
        for tc in tabContents
            tc.classList.remove("active")
            tc = document.querySelectorAll('.' + contentClassName + '.' + tabName)
            tci.classList.add("active") for tci in tc
    for tab in tabs
        tab.onclick = () -> clickTab(this)
        

@triggersInit = (trigClassname = "trigger", trigContentName = "trigged") ->
    trigs = document.querySelectorAll("." + trigClassname)
    trigged = document.querySelectorAll("." + trigContentName)
        
    clickTrig = (trig) ->
        trigName = ""
        trigState = "off"
        re = new RegExp(trigClassname + "\\d");
        for cName in trig.classList
            if cName.match(re) != null
                trigName = cName
            if cName == "off" || cName == "on"
                trigState = cName
        for td in trigged
            td.classList.remove("active")
        if(trigState == "on")
            trig.classList.remove("on")
            trig.classList.add("off")
            trigState = "off"
        else
            trig.classList.remove("off")
            trig.classList.add("on")
            trigState = "on"
        for td in document.querySelectorAll("." + trigContentName)
            if td.classList.contains(trigName)
                if trigState == "on"
                    td.classList.add("active")
                else
                    td.classList.remove("active")
    for t in trigs
        t.onclick = () -> clickTrig(this)