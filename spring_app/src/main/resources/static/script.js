document.getElementById('action-button').addEventListener('click', function() {
    const messageElement = document.getElementById('message');
    messageElement.textContent = "You clicked the button!";
    messageElement.style.color = '#ff0066';
    messageElement.style.transform = 'scale(1.1)';
    setTimeout(() => {
        messageElement.style.transform = 'scale(1)';
    }, 200);
});