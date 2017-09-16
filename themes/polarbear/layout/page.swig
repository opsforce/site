{% extends "_layout.swig" %}

{% block title %} {{ page.title }} - {{ config.title }} {% endblock %}

{% block content %}
    <div id="primary">
        <article class="post">
            <header class="post-header">
                <h1 class="post-title">
                    {{ page.title }}
                </h1>
            </header>
            <div class="post-content">
                {{ page.content }}
                <!-- 2017-09-10 添加捐款 START -->
                <iframe src="/donate/" style="overflow-x:hidden;overflow-y:hidden; border:0xp none #fff; min-height:240px; width:100%;"  frameborder="0" scrolling="no"></iframe>
                <!-- 2017-09-10 添加捐款 END -->
            </div>
        </article>
    </div>
{% endblock %}
