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

###
# EXAMPLE
###
###

<script type="text/javascript" src="tabLogic.js"></script>

<div class="tab active tab1">A</div>
<div class="tab tab2">B</div>
<div class="tab tab3">C</div>

<div class="tabContent tab1 active">
    <p>XXX</p>
</div>
<div class="tabContent tab2">
    <p>YYY</p>
    <div class="tab_ active tab_1">A</div>
    <div class="tab_ tab_2">B</div>
    <div class="tab_ tab_3">C</div>

    <div class="tabContent_ tab_1 active">
        <p>XXX</p>
    </div>
    <div class="tabContent_ tab_2">
        <p>YYY</p>
    </div>
    <div class="tabContent_ tab_3">
        <p>ZZZ</p>
    </div>
</div>
<div class="tabContent tab3">
    <p>ZZZ</p>
</div>

<a class="trigger trigger1 off">push me</a>
<div class="map trigged trigger1" >
    <p>now you see me</p>
</div>

<script type="text/javascript">
    tabsInit("tab", "tabContent");
    tabsInit("tab_", "tabContent_");
    triggersInit("trigger", "trigged");
</script>

###