<span class="copyright-year">
    {% set current = date(Date.now(), "YYYY") %}
        &copy;
    {% if theme.since and theme.since != current %}
        {{ theme.since }} -
    {% endif %}
    {{ current }}
    <span class="footer-author">{{ config.author }} |</span>
    <span class="power-by">
        {{ __('footer.powered', '<a class="hexo-link" href="https://hexo.io/">Hexo</a> and <a class="theme-link" href="https://github.com/frostfan/hexo-theme-polarbear">PolarBear</a>') }} |
    </span>

    <!-- 2017-09-09 添加文章字数统计及阅读时间 START -->
    <!-- https://github.com/willin/hexo-wordcount -->
    <span class="post-count">{{ totalcount(site, '0,0.0a') }} words total |</span>
    <!-- 2017-09-10 添加文章字数统计及阅读时间 END -->
    
    <!-- 2017-09-09 How to Add Visitors Count to Your Website START -->
    <!-- http://bryanyzhu.github.io/2015/12/17/all_about_hexo_III/ http://busuanzi.ibruce.info -->
    <span id="busuanzi_container_site_uv">
    You got <span id="busuanzi_value_site_uv"></span> visitors
    </span>
    <!-- 2017-09-09 How to Add Visitors Count to Your Website END -->

</span>
