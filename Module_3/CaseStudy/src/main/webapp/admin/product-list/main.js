document.querySelectorAll('.btn-delete').forEach(button => {
    button.addEventListener('click', function () {
        const id = this.getAttribute('data-id');
        const name = this.getAttribute('data-name');

        document.getElementById('delId').value = id;
        document.getElementById('delName').textContent = name;
    });
});
