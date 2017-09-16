{% macro render(post) %}
  <article class="post">
    <header class="post-header">
      <h1 class="post-title">
        {% if is_home() %}
          <a class="post-link" href="{{ url_for(post.path) }}">{{ post.title }}</a>
        {% else %}
          {{ post.title }}
        {% endif %}
      </h1>

      <time class="post-time">
          
          <!-- 2017-09-09 添加文章字数统计及阅读时间 START -->
          <!-- https://github.com/willin/hexo-wordcount -->
          {{ full_date(post.date, 'MMM D YYYY') }} | <span class="post-count">{{ wordcount(post.content) }} words</span> | <span class="post-count">{{ min2read(post.content) }} min read</span>
          <!-- 2017-09-10 添加文章字数统计及阅读时间 END -->

      </time>
    </header>



    {% if is_home() %}
        <div class="post-excerpt">
            {% set excerpt = "" %}
            {% if post.description %}
              {% set excerpt = post.description %}
            {% elif post.excerpt %}
              {% set excerpt = post.excerpt %}
            {% endif %}

            {% if excerpt %}
              {{ excerpt }}
        </div>
            {% endif %}
          {% else %}
            <div class="post-content">
            {{ post.content }}
            </div>
          {% endif %}

    {% if not is_home() %}
      
      <!-- 2017-09-10 添加捐款 START -->
      <iframe src="/donate/" style="overflow-x:hidden;overflow-y:hidden; border:0xp none #fff; min-height:240px; width:100%;"  frameborder="0" scrolling="no"></iframe>
      <!-- 2017-09-10 添加捐款 END -->

      <!-- 2017-09-10 添加版权信息 START -->
      <!-- https://arcecho.github.io/2017/04/08/Hexo-Next下添加版权声明模块/ -->
      <div>    
        {# 表示如果不在索引列表中加入后续的HTML代码 #}
        <ul class="post-copyright">
          <li class="post-copyright-author">
            <strong>本文作者：</strong>{{ theme.author }}
          </li>
          <li class="post-copyright-link">
            <strong>本文链接：</strong>
            <a href="{{ url_for(page.path) }}" title="{{ page.title }}">{{ page.path }}</a>
          </li>
          <li class="post-copyright-license">
            <strong>版权声明： </strong>
            本博客所有文章除特别声明外，均采用 <a href="http://creativecommons.org/licenses/by-nc-sa/3.0/cn/" rel="external nofollow" target="_blank">CC BY-NC-SA 3.0 CN</a> 许可协议。转载请注明出处！
          </li>
        </ul>
      </div>
      <!-- 2017-09-10 添加版权信息 END -->

      <footer class="post-footer">
		{% if post.tags and post.tags.length %}
		<div class="post-tags">
		  {% for tag in post.tags %}
			<a href="{{ url_for(tag.path) }}">{{ tag.name }}</a>
		  {% endfor %}
		</div>
		{% endif %}

        {# Post Pagination #}
        {% include "../_partial/pagination.swig" %}
        {% include "../_partial/comments.swig" %}
      </footer>
    {% endif %}
  </article>
{% endmacro %}
