document.addEventListener('DOMContentLoaded', function () {
    // Mobile Menu
    const mobileMenuBtn = document.querySelector('.mobile-menu-btn');
    const sidebar = document.querySelector('.sidebar');
    const mainContent = document.querySelector('.main-content');

    if (mobileMenuBtn) {
        mobileMenuBtn.addEventListener('click', function () {
            sidebar.classList.toggle('active');
            mainContent.classList.toggle('shifted');
        });
    }

    // User Activity Chart
    const userActivityCtx = document.getElementById('userActivityChart').getContext('2d');
    const userActivityChart = new Chart(userActivityCtx, {
        type: 'line',
        data: {
            labels: ['Apr 5', 'Apr 6', 'Apr 7', 'Apr 8', 'Apr 9', 'Apr 10', 'Apr 11'],
            datasets: [
                {
                    label: 'Active Users',
                    data: [2850, 3100, 2950, 3200, 3300, 3450, 3542],
                    borderColor: '#4a6fa5',
                    backgroundColor: 'rgba(74, 111, 165, 0.1)',
                    tension: 0.4,
                    fill: true
                },
                {
                    label: 'AR Sessions',
                    data: [920, 1050, 980, 1100, 1150, 1200, 1256],
                    borderColor: '#6b8c42',
                    backgroundColor: 'rgba(107, 140, 66, 0.1)',
                    tension: 0.4,
                    fill: true
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            interaction: {
                mode: 'index',
                intersect: false,
            },
            plugins: {
                legend: { position: 'top' },
                tooltip: { enabled: true }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: { color: 'rgba(0, 0, 0, 0.05)' }
                },
                x: {
                    grid: { display: false }
                }
            }
        }
    });

    // Revenue Chart
    const revenueCtx = document.getElementById('revenueChart').getContext('2d');
    const revenueChart = new Chart(revenueCtx, {
        type: 'bar',
        data: {
            labels: ['Apr 5', 'Apr 6', 'Apr 7', 'Apr 8', 'Apr 9', 'Apr 10', 'Apr 11'],
            datasets: [
                {
                    label: 'Tour Packages',
                    data: [12500, 11800, 13200, 14500, 15100, 14800, 15600],
                    backgroundColor: '#ff7e5f',
                },
                {
                    label: 'Individual Bookings',
                    data: [8200, 7900, 8700, 9100, 9500, 9200, 9800],
                    backgroundColor: '#6b8c42',
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { position: 'top' },
                tooltip: {
                    callbacks: {
                        label: function (context) {
                            let label = context.dataset.label || '';
                            if (label) label += ': ';
                            if (context.parsed.y !== null) {
                                label += new Intl.NumberFormat('en-US', {
                                    style: 'currency',
                                    currency: 'USD'
                                }).format(context.parsed.y);
                            }
                            return label;
                        }
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        callback: function (value) {
                            return '$' + value.toLocaleString();
                        }
                    },
                    grid: { color: 'rgba(0, 0, 0, 0.05)' }
                },
                x: {
                    grid: { display: false }
                }
            }
        }
    });
});
