# Generated by Django 5.1.2 on 2024-11-18 15:16

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('dnd_app', '0006_remove_race_id_race_race_id_alter_race_descript_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='race',
            name='descript',
            field=models.TextField(),
        ),
    ]
