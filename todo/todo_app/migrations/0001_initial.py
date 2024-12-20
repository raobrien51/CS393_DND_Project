# Generated by Django 5.1.2 on 2024-10-16 18:20

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Status',
            fields=[
                ('statusId', models.AutoField(primary_key=True, serialize=False)),
                ('statusName', models.CharField(max_length=50)),
                ('statusColor', models.CharField(max_length=6)),
            ],
        ),
        migrations.CreateModel(
            name='Task',
            fields=[
                ('taskId', models.AutoField(primary_key=True, serialize=False, verbose_name='Task ID')),
                ('title', models.CharField(max_length=255)),
                ('description', models.TextField(null=True)),
                ('dueDate', models.DateTimeField()),
                ('createdAt', models.DateTimeField(auto_now_add=True)),
                ('updatedAt', models.DateTimeField(auto_now=True)),
                ('status', models.ForeignKey(on_delete=django.db.models.deletion.RESTRICT, to='todo_app.status')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.RESTRICT, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
