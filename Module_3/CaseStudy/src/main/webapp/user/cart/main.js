function updateSummary() {
    const checkboxes = document.querySelectorAll('.item-checkbox');
    let totalQuantity = 0;
    let subtotal = 0;

    checkboxes.forEach(cb => {
        if (cb.checked) {
            const quantity = parseInt(cb.dataset.quantity);
            const price = parseFloat(cb.dataset.price);
            totalQuantity += quantity;
            subtotal += quantity * price;
        }
    });

    document.getElementById('summary-count').textContent = totalQuantity;
    document.getElementById('summary-subtotal').textContent = subtotal.toFixed(2) + "$";
    document.getElementById('summary-total').textContent = subtotal.toFixed(2) + "$";
}

// Cập nhật khi checkbox thay đổi
document.querySelectorAll('.item-checkbox').forEach(cb => {
    cb.addEventListener('change', updateSummary);
});

// Gọi lần đầu khi trang load
window.addEventListener('DOMContentLoaded', updateSummary);

