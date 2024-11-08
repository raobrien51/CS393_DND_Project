from django.db import models

# Create your models here.
from django.db import models

class Character_Class(models.Model):
    charatcer_id = models.AutoField(primary_key=True)
    character_name = models.CharField(max_length=255)
    STR = models.IntegerField()
    DEX = models.IntegerField()
    CON = models.IntegerField()
    INTE = models.IntegerField()
    WIS = models.IntegerField()
    CHA = models.IntegerField()
    #BackgroundID FK
    #RaceID FK

    def __str__(self):
        return f"{self.character_name}"
    
    class Meta:
        db_table = "Character_Class"

"""class Teacher(models.Model):
    teacher_id = models.AutoField(primary_key=True)
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)
    department = models.CharField(max_length=100)

    def __str__(self):
        return f"{self.first_name} {self.last_name} - {self.department}"
    
    class Meta:
        db_table = "Teachers"

class Course(models.Model):
    course_id = models.AutoField(primary_key=True)
    course_name = models.CharField(max_length=100)
    teacher = models.ForeignKey(Teacher, on_delete=models.CASCADE)
    credits = models.IntegerField()
    students = models.ManyToManyField(Student, related_name='courses', through='Enrollment')

    def __str__(self):
        return self.course_name
    
    class Meta:
        db_table = "Courses"

class Enrollment(models.Model):
    enrollment_id = models.AutoField(primary_key=True)
    student = models.ForeignKey(Student, on_delete=models.CASCADE)
    course = models.ForeignKey(Course, on_delete=models.CASCADE)
    enrollment_date = models.DateField()

    def __str__(self):
        return f"{self.student} enrolled in {self.course}"
    
    class Meta:
        unique_together = ('student', 'course')
        db_table = "Enrollments"
        """
