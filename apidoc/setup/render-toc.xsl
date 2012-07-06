<!-- This stylesheet renders the pre-generated XML TOC
     into HTML to be cached by browsers.
-->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:toc="http://marklogic.com/rundmc/api/toc"
  xmlns:api="http://marklogic.com/rundmc/api"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="xs toc api">

  <xsl:param name="toc-url"/>

  <!-- Optional version-specific prefix for link hrefs, e.g., "/4.2" -->
  <xsl:param name="prefix-for-hrefs"/>

  <xsl:variable name="toc-parts-dir" select="concat($toc-url,'/')"/>

  <xsl:template match="/">
    <xsl:message>Creating <xsl:value-of select="$toc-url"/></xsl:message>
    <xsl:result-document href="{$toc-url}">
      <div id="all_tocs">
        <script type="text/javascript">
        //<xsl:comment>

        $(function() {
          $("#apidoc_tree1").treeview({
            //animated: "medium",
            url: "<xsl:value-of select="$toc-parts-dir"/>",
//            persist: "location",
            prerendered: true
          });
          $("#apidoc_tree2").treeview({
            //animated: "medium",
            url: "<xsl:value-of select="$toc-parts-dir"/>",
//            persist: "location",
            prerendered: true
          });
          $("#apidoc_tree3").treeview({
            //animated: "medium",
            url: "<xsl:value-of select="$toc-parts-dir"/>",
//            persist: "location",
            prerendered: true
          });
          $("#apidoc_tree4").treeview({
            //animated: "medium",
            url: "<xsl:value-of select="$toc-parts-dir"/>",
//            persist: "location",
            prerendered: true
          });
          $("#apidoc_tree5").treeview({
            //animated: "medium",
            url: "<xsl:value-of select="$toc-parts-dir"/>",
//            persist: "location",
            prerendered: true
          });


          $("#config-filter1").keyup(function(e) {
              currentFilterText = $(this).val();
              setTimeout(function() {
                  if (previousFilterText !== currentFilterText){
                      previousFilterText = currentFilterText;
                      filterConfigDetails(currentFilterText,"#apidoc_tree1");
                  }            
              },350);        
          });

          $("#config-filter2").keyup(function(e) {
              currentFilterText2 = $(this).val();
              setTimeout(function() {
                  if (previousFilterText2 !== currentFilterText2){
                      previousFilterText2 = currentFilterText2;
                      filterConfigDetails(currentFilterText2,"#apidoc_tree2");
                  }            
              },350);        
          });
          
          $("#config-filter3").keyup(function(e) {
              currentFilterText3 = $(this).val();
              setTimeout(function() {
                  if (previousFilterText3 !== currentFilterText3){
                      previousFilterText3 = currentFilterText3;
                      filterConfigDetails(currentFilterText3,"#apidoc_tree3");
                  }            
              },350);        
          });

          $("#config-filter4").keyup(function(e) {
              currentFilterText4 = $(this).val();
              setTimeout(function() {
                  if (previousFilterText4 !== currentFilterText4){
                      previousFilterText4 = currentFilterText4;
                      filterConfigDetails(currentFilterText4,"#apidoc_tree4");
                  }
              },350);
          });

          $("#config-filter5").keyup(function(e) {
              currentFilterText4 = $(this).val();
              setTimeout(function() {
                  if (previousFilterText4 !== currentFilterText4){
                      previousFilterText4 = currentFilterText4;
                      filterConfigDetails(currentFilterText4,"#apidoc_tree4");
                  }
              },350);
          });

          // default text, style, etc.
          formatFilterBoxes($("#config-filter1, #config-filter2, #config-filter3, #config-filter4, #config-filter5"));

        });

        // starting the script on page load
        $(document).ready(function(){
          
          // Wire up the expand/collapse buttons
          $(".shallowExpand").click(function(event){
            shallowExpandAll($(this).parent().nextAll("ul"));
          });
          $(".shallowCollapse").click(function(event){
            shallowCollapseAll($(this).parent().nextAll("ul"));
          });
          $(".expand").click(function(event){
            expandAll($(this).parent().nextAll("ul"));
          });
          $(".collapse").click(function(event){
            collapseAll($(this).parent().nextAll("ul"));
          });


          // Set up the TOC tabs
          $("#toc_tabs").tabs({
            show: function(event, ui){ updateTocForTab(ui.tab, ui.panel) }
          });

          bindFragmentLinkTocActions(document.body);
          initializeTOC();

          <!-- Search sidebar isn't going here after all (at least currently)
          var searchSidebarContent = $("#search_sidebar").children();

          // Only replace the default form if search sidebar content is present (because we're on the search page)
          if (searchSidebarContent.length)
            $("#search_pane_content form").replaceWith(searchSidebarContent);

          var last_tab_pos = $("#toc_tabs").tabs("length") - 1;

          if (window.location.pathname === "/srch")
            $("#toc_tabs").tabs("option", "selected", last_tab_pos);
          -->

          // Once the tabs are set up, go ahead and display the TOC
//          $("#toc_tabs").show();

        });
        //</xsl:comment>
        </script>

        <!--
        <div>API Reference</div>
        -->
        <div id="toc_tabs" class="toc_tabs">
          <div id="tab_bar">
            <ul>
              <xsl:apply-templates mode="tab" select="/all-tocs/*"/>
            </ul>
          </div>
          <div id="tab_content">
            <xsl:apply-templates mode="tab-content" select="/all-tocs/*"/>
          </div>
        </div>
      </div>
    </xsl:result-document>
  </xsl:template>

          <xsl:template mode="tab" match="/all-tocs/*">
            <li>
              <a href="#tabs-{position()}" class="tab_link">
                <xsl:apply-templates mode="tab-label" select="."/>
              </a>
            </li>
          </xsl:template>

                  <xsl:template mode="tab-label" match="toc:functions"     >XQuery/<br/>XSLT</xsl:template>
                  <!--
                  <xsl:template mode="tab-label" match="toc:categories"    >API by<br/>Category</xsl:template>
                  -->
                  <xsl:template mode="tab-label" match="toc:guides">Guides</xsl:template>
                  <xsl:template mode="tab-label" match="toc:rest-resources">REST<br/>API</xsl:template>
		  <xsl:template mode="tab-label" match="toc:java"          >Java<br/>Client</xsl:template>
                  <!--
                  <xsl:template mode="tab-label" match="toc:help"          >Admin<br/>Help</xsl:template>
                  -->
                  <xsl:template mode="tab-label" match="toc:other"         >Other<br/>Docs</xsl:template>


          <xsl:template mode="tab-content" match="/all-tocs/*">
            <xsl:variable name="pjax_enabled">
              <xsl:apply-templates mode="pjax_enabled" select="."/>
            </xsl:variable>
            <xsl:variable name="pos" select="position()"/>
            <div id="tabs-{$pos}" class="tabbed_section {$pjax_enabled} {local-name(.)}">
                                                                        <!-- e.g., "guides" -->
              <div class="scrollable_section">
                <input id="config-filter{$pos}" name="config-filter{$pos}"/>
                <xsl:apply-templates mode="control" select="."/>
                <ul id="apidoc_tree{$pos}" class="treeview">
                  <xsl:apply-templates select="node"/>
                </ul>
              </div>
            </div>
          </xsl:template>

                  <xsl:template mode="pjax_enabled" match="*">pjax_enabled</xsl:template>
                  <!-- Let's *make* it work well...
                  <xsl:template mode="pjax_enabled" match="toc:guides"/> <!- - PJAX disabled to/from user guides; doesn't work well - ->
                  -->


          <!-- We hide the "all" container so it doesn't appear in the TOC -->
          <xsl:template match="node[@hidden eq 'yes']">
            <xsl:apply-templates select="node"/>
          </xsl:template>

          <xsl:template match="node">
            <xsl:variable name="class">
              <xsl:apply-templates mode="class" select="."/>
              <xsl:text> </xsl:text>
              <xsl:apply-templates mode="class-last" select="."/>
              <xsl:text> </xsl:text>
              <xsl:apply-templates mode="class-hasChildren" select="."/>
              <xsl:text> </xsl:text>
              <xsl:apply-templates mode="class-initialized" select="."/>
              <xsl:text> </xsl:text>
              <xsl:apply-templates mode="class-async" select="."/>
            </xsl:variable>
            <li class="{$class}">
              <xsl:apply-templates mode="id-att"   select="."/>
              <xsl:apply-templates mode="hit-area" select="."/>
              <xsl:apply-templates mode="link"     select="."/>
              <xsl:apply-templates mode="control"  select="."/>
              <xsl:apply-templates mode="children" select="."/>
            </li>
          </xsl:template>

                  <xsl:template mode="id-att" match="node"/>
                  <!-- Include an ID on nodes that have one already -->
                  <xsl:template mode="id-att" match="node[@id]">
                    <xsl:attribute name="id">
                      <xsl:apply-templates mode="node-id" select="."/>
                    </xsl:attribute>
                  </xsl:template>

                          <xsl:template mode="node-id" match="node">
                            <xsl:value-of select="@id"/>
                          </xsl:template>


                  <xsl:template mode="class" priority="1" match="node[@open]">collapsable</xsl:template> <!-- yes, I know this is misspelled -->
                  <xsl:template mode="class"              match="node[node] ">expandable</xsl:template>
                  <xsl:template mode="class"              match="node"/>


                  <xsl:template mode="class-last" priority="2" match="node[last()][@open] ">lastCollapsable</xsl:template>
                  <xsl:template mode="class-last" priority="1" match="node[last()][node]  ">lastExpandable</xsl:template>
                  <xsl:template mode="class-last"              match="node[last()]        ">last</xsl:template>
                  <xsl:template mode="class-last"              match="node                "/>

                  <!-- Include on nodes that will be loaded asynchronously -->
                  <xsl:template mode="class-hasChildren" match="node[@async]">hasChildren</xsl:template>
                  <xsl:template mode="class-hasChildren" match="node"/>

                  <!-- Include on nodes that have an @id (used by list pages to identify the relevant TOC section) but that aren't loaded asynchronously (because they're already loaded) -->
                  <xsl:template mode="class-initialized" match="node[@id][not(@async)]">loaded initialized</xsl:template>
                  <xsl:template mode="class-initialized" match="node"/>

                  <!-- Mark the asynchronous (unpopulated) nodes as such so the JavaScript can act accordingly -->
                  <xsl:template mode="class-async" match="node[@async]">async</xsl:template>
                  <xsl:template mode="class-async" match="node"/>


                  <xsl:template mode="hit-area" match="node"/>
                  <xsl:template mode="hit-area" match="node[node]">
                    <xsl:variable name="class">
                      <xsl:apply-templates mode="hit-area-class"      select="."/>
                      <xsl:text> </xsl:text>
                      <xsl:apply-templates mode="hit-area-class-last" select="."/>
                    </xsl:variable>
                    <div class="{$class}"/>
                  </xsl:template>

                          <xsl:template mode="hit-area-class" match="node[@open]">hitarea collapsable-hitarea</xsl:template>
                          <xsl:template mode="hit-area-class" match="node       ">hitarea expandable-hitarea</xsl:template>

                          <xsl:template mode="hit-area-class-last" priority="1" match="node[last()][@open]">lastCollapsable-hitarea</xsl:template>
                          <xsl:template mode="hit-area-class-last"              match="node[last()]       ">lastExpandable-hitarea</xsl:template>
                          <xsl:template mode="hit-area-class-last"              match="node               "/>

                  <!-- re-enable should we need this
                  <xsl:template mode="class-att" match="node[@type eq 'function']">
                    <xsl:attribute name="class" select="'function_name'"/>
                  </xsl:template>
                  -->

                  <xsl:template mode="link" match="node">
                    <span>
                      <xsl:apply-templates mode="node-display" select="."/>
                    </span>
                  </xsl:template>

                  <xsl:template mode="link" match="node[@href]">
                    <xsl:variable name="href">
                      <xsl:value-of select="$prefix-for-hrefs"/>
                      <xsl:apply-templates mode="link-href" select="."/>
                    </xsl:variable>
                    <a href="{$href}">
                      <xsl:apply-templates mode="external-atts" select="."/>
                      <xsl:apply-templates mode="title-att" select="."/>
                      <xsl:apply-templates mode="node-display" select="."/>
                    </a>
                    <!-- Not really helpful
                    <xsl:if test="@footnote">
                      <a class="footnote_marker tooltip" title="Built-in functions (not written in XQuery)">*</a>
                    </xsl:if>
                    -->
                  </xsl:template>

                          <!-- For external links (outside the docs template) -->
                          <xsl:template mode="external-atts" match="node"/>
                          <xsl:template mode="external-atts" match="node[@external]">
                            <xsl:attribute name="class" select="'external'"/>
                            <xsl:attribute name="target" select="'_blank'"/>
                          </xsl:template>


                          <xsl:template mode="node-display" match="node">
                            <xsl:value-of select="@display"/>
                          </xsl:template>

                          <xsl:template mode="node-display" match="node[@function-count]">
                            <xsl:next-match/>
                            <span class="function_count">
                              <xsl:text> (</xsl:text>
                              <xsl:value-of select="@function-count"/>
                              <xsl:text>)</xsl:text>
                            </span>
                          </xsl:template>


                          <!-- For most cases, just append the @href value after the optional version prefix -->
                          <xsl:template mode="link-href" match="node">
                            <xsl:value-of select="@href"/>
                          </xsl:template>

                          <!-- But when the @href value is just "/", leave it out when the version is specified explicitly (e.g., /4.2 instead of /4.2/) -->
                          <xsl:template mode="link-href" match="node[string($prefix-for-hrefs)][@href eq '/']"/>


                          <xsl:template mode="title-att" match="node"/>
                          <xsl:template mode="title-att" match="node[@namespace]">
                            <xsl:attribute name="title" select="@namespace"/>
                          </xsl:template>

                  <xsl:template mode="control" match="*"/>
                  <!-- Expand/collapse buttons are enabled for all top-level menus, as well as globally for guides and categories -->
                  <xsl:template mode="control" match="(:toc:functions/node |:) toc:guides (:| toc:categories:) | toc:rest-resources | toc:other | toc:java
                                                    | toc:functions
                                                    (:|toc:categories/node:)
                                                    | toc:functions/node[1]/node (: category buckets :)
                                                    | toc:guides/node/node">
                    <xsl:variable name="collapse-class">
                      <xsl:apply-templates mode="collapse-class" select="."/>
                    </xsl:variable>
                    <xsl:variable name="expand-class">
                      <xsl:apply-templates mode="expand-class" select="."/>
                    </xsl:variable>
                    <xsl:variable name="all-suffix">
                      <xsl:apply-templates mode="all-suffix" select="."/>
                    </xsl:variable>
                    <xsl:variable name="top_control">
                      <xsl:apply-templates mode="top_control-class" select="."/>
                    </xsl:variable>
                    <xsl:variable name="local_control">
                      <xsl:apply-templates mode="local_control-class" select="."/>
                    </xsl:variable>
                    <div style="font-size:.8em" class="treecontrol {$top_control} {$local_control}">
                      <xsl:text>&#160;</xsl:text>
                      <span title="Collapse the entire tree below" class="{$collapse-class}"><img src="/css/apidoc/images/minus.gif" /> collapse<xsl:value-of select="$all-suffix"/></span>
                      <xsl:text>&#160;</xsl:text>
                      <span title="Expand the entire tree below" class="{$expand-class}"><img src="/css/apidoc/images/plus.gif" /> expand<xsl:value-of select="$all-suffix"/></span>
                    </div>
                  </xsl:template>

                          <!-- Shallow for top-level menus -->
                          <!--
                          <xsl:template mode="collapse-class" match="toc:functions/node">shallowCollapse</xsl:template>
                          <xsl:template mode="expand-class"   match="toc:functions/node">shallowExpand</xsl:template>
                          -->
                          <xsl:template mode="all-suffix"     match="(:toc:functions/node | toc:rest-resources/node | toc:guides/node
                                                                   |:) toc:*"/> <!-- Don't ever display "all" at the top (in the blue buttons) -->

                          <!-- Recursive (full) for everything else -->
                          <xsl:template mode="collapse-class" match="node | toc:*">collapse</xsl:template>
                          <xsl:template mode="expand-class"   match="node | toc:*">expand</xsl:template>
                          <xsl:template mode="all-suffix"     match="node"> all</xsl:template>

                          <!-- top_control is styled to appear at the top as a blue button -->
                          <xsl:template mode="top_control-class" match="node"/>
                          <xsl:template mode="top_control-class" match="toc:functions/node | toc:rest-resources/node | toc:*">top_control</xsl:template>

                          <!-- this distinction is necessary for top_control (blue) buttons in order to get the correct positioning offsets -->
                          <xsl:template mode="local_control-class" match="node">local_control</xsl:template>
                          <xsl:template mode="local_control-class" match="toc:*">global_control</xsl:template>


                  <xsl:template mode="children" match="node"/>
                  <xsl:template mode="children" match="node[node]"> <!-- also next-match for node[@async] -->
                    <xsl:variable name="display-type">
                      <xsl:apply-templates mode="ul-display-type" select="."/>
                    </xsl:variable>
                    <ul style="display: {$display-type};">
                      <xsl:apply-templates select="node"/>
                    </ul>
                  </xsl:template>

                  <!-- Nodes to be loaded asynchronously -->
                  <xsl:template mode="children" match="node[@async]" priority="1">
                    <!-- The empty placeholder -->
                    <ul style="display: none">
                      <li>
                        <span class="placeholder">&#160;</span>
                      </li>
                    </ul>
                    <xsl:variable name="url">
                      <xsl:value-of select="$toc-parts-dir"/>
                      <xsl:apply-templates mode="node-id" select="."/>
                      <xsl:text>.html</xsl:text>
                    </xsl:variable>
                    <!-- The content of the TOC node, stored in a separate document -->
                    <xsl:message>Creating <xsl:value-of select="$url"/></xsl:message>
                    <xsl:result-document href="{$url}">
                      <xsl:next-match/>
                    </xsl:result-document>
                  </xsl:template>

                          <xsl:template mode="ul-display-type" match="node[@open or @async]">block</xsl:template>
                          <xsl:template mode="ul-display-type" match="node                 ">none</xsl:template>

</xsl:stylesheet>
