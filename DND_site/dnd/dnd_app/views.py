from django.shortcuts import render, get_object_or_404, redirect
from .models import *
from django.utils import timezone
from django.http import Http404

# Create your views here.
def index(request):
    return render(request, "dnd_app/main.html")

def character_list(request):
    data = Character_Class.objects.all()
    context = {'Characters': data}
    return render(request, "dnd_app/character_list.html", context)

def classes(request):
    data = Classes.objects.all()
    context = {'Classes': data}
    return render(request, "dnd_app/classes.html", context)
def feat(request):
    data = Feat.objects.all()
    context = {'Feat': data}
    return render(request, "dnd_app/feat.html", context)
def spell(request):
    data = Spell.objects.all()
    context = {'Spell': data}
    return render(request, "dnd_app/spell.html", context)
def race(request):
    data = Race.objects.all()
    context = {'Race': data}
    return render(request, "dnd_app/race.html", context)

"""def course_list(request):
    data = Course.objects.all()
    context = {'courses': data}
    return render(request, "school_app/course_list.html", context)

def course_detail(request, course_id, message=None):
    course = get_object_or_404(Course, course_id=course_id)
    enrolled_students = course.students.all()  # Accessing related students

    return render(request, 'school_app/course_detail.html', {
        'course': course,
        'enrolled_students': enrolled_students,
        'message': message,
    })

def student_list(request):
    data = Student.objects.all()
    context= {"students": data}
    return render(request, 'school_app/student_list.html', context)

def enroll_student(request):
    if request.method == "POST":
        form = EnrollmentForm(request.POST)

        if form.is_valid():
            student = get_object_or_404(Student, student_id=form.cleaned_data["student_id"])
            course = get_object_or_404(Course, course_id=form.cleaned_data["course_id"])
            
            # Check if enrollment already exists
            enrollment, created = Enrollment.objects.get_or_create(
                student=student,
                course=course,
                defaults={'enrollment_date': timezone.now()}
            )

            if created:
                message = f"{student.first_name} has been enrolled in {course.course_name}."
            else:
                message = f"{student.first_name} is already enrolled in {course.course_name}."

            print(message)

            return redirect('course_detail', course_id=course.course_id)
        else:
            return redirect('enroll_student')
    else:
        form = EnrollmentForm()
        return render(request, "school_app/enrollment_form.html", {"form": form})"""
