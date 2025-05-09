document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        document.querySelector(this.getAttribute('href')).scrollIntoView({
            behavior: 'smooth'
        });
    });
});
const currentLocation = location.href;
const menuItems = document.querySelectorAll('nav ul li a');
menuItems.forEach(item => {
    if (item.href === currentLocation) {
        item.classList.add('active');
    }
});
const submitForm = (event) => {
    event.preventDefault();
    const data = {
        name: document.getElementById('name').value.trim(),
        email: document.getElementById('email').value.trim(),
        message: document.getElementById('message').value.trim()
    };
    fetch("MyAPI", {
        method: 'POST',
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(data)
    })
    .then(response => response.json())
    .then(result => alert(result.body || "Submission was successful!"))
    .catch(() => alert("An error occurred while submitting the form"));
};
document.getElementById("contactForm").addEventListener("submit", submitForm);