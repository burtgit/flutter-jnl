// Mobile Navigation Toggle
document.addEventListener('DOMContentLoaded', function() {
    const navToggle = document.querySelector('.nav-toggle');
    const navMenu = document.querySelector('.nav-menu');
    
    if (navToggle && navMenu) {
        navToggle.addEventListener('click', function() {
            navMenu.classList.toggle('active');
            navToggle.classList.toggle('active');
        });
    }
    
    // Close mobile menu when clicking on a link
    const navLinks = document.querySelectorAll('.nav-menu a');
    navLinks.forEach(link => {
        link.addEventListener('click', () => {
            navMenu.classList.remove('active');
            navToggle.classList.remove('active');
        });
    });
});

// Smooth Scrolling for Navigation Links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            const headerHeight = document.querySelector('.header').offsetHeight;
            const targetPosition = target.offsetTop - headerHeight;
            
            window.scrollTo({
                top: targetPosition,
                behavior: 'smooth'
            });
        }
    });
});

// Header Background on Scroll
window.addEventListener('scroll', function() {
    const header = document.querySelector('.header');
    if (window.scrollY > 100) {
        header.style.background = 'rgba(255, 255, 255, 0.98)';
        header.style.boxShadow = '0 2px 20px rgba(0, 0, 0, 0.1)';
    } else {
        header.style.background = 'rgba(255, 255, 255, 0.95)';
        header.style.boxShadow = 'none';
    }
});

// Animate Elements on Scroll
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
};

const observer = new IntersectionObserver(function(entries) {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
        }
    });
}, observerOptions);

// Observe elements for animation
document.addEventListener('DOMContentLoaded', function() {
    const animateElements = document.querySelectorAll('.feature-card, .category-card, .contact-item');
    
    animateElements.forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(30px)';
        el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        observer.observe(el);
    });
});

// Counter Animation for Hero Stats
function animateCounter(element, target, duration = 2000) {
    let start = 0;
    const increment = target / (duration / 16);
    
    function updateCounter() {
        start += increment;
        if (start < target) {
            element.textContent = Math.floor(start) + '+';
            requestAnimationFrame(updateCounter);
        } else {
            element.textContent = target + '+';
        }
    }
    
    updateCounter();
}

// Trigger counter animation when hero section is visible
const heroObserver = new IntersectionObserver(function(entries) {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            const statNumbers = document.querySelectorAll('.stat-number');
            statNumbers.forEach((stat, index) => {
                const targets = [4, 100, 100000]; // Corresponding to the stats
                const displayTargets = ['4', '100', '10万'];
                
                setTimeout(() => {
                    if (index < 2) {
                        animateCounter(stat, targets[index]);
                    } else {
                        // Special handling for 10万+
                        let start = 0;
                        const target = 100000;
                        const increment = target / (2000 / 16);
                        
                        function updateCounter() {
                            start += increment;
                            if (start < target) {
                                if (start < 10000) {
                                    stat.textContent = Math.floor(start / 1000) + '千+';
                                } else {
                                    stat.textContent = Math.floor(start / 10000) + '万+';
                                }
                                requestAnimationFrame(updateCounter);
                            } else {
                                stat.textContent = '10万+';
                            }
                        }
                        
                        updateCounter();
                    }
                }, index * 200);
            });
            
            heroObserver.unobserve(entry.target);
        }
    });
}, { threshold: 0.5 });

document.addEventListener('DOMContentLoaded', function() {
    const heroSection = document.querySelector('.hero');
    if (heroSection) {
        heroObserver.observe(heroSection);
    }
});

// App Preview Tab Switching
document.addEventListener('DOMContentLoaded', function() {
    const tabs = document.querySelectorAll('.tab');
    const couponCards = document.querySelector('.app-content');
    
    const tabContent = {
        0: [ // 饿了么
            { icon: 'fas fa-utensils', text: '超级星势力' },
            { icon: 'fas fa-gift', text: '新人红包' }
        ],
        1: [ // 美团
            { icon: 'fas fa-motorcycle', text: '外卖红包' },
            { icon: 'fas fa-star', text: '会员特权' }
        ],
        2: [ // 出行
            { icon: 'fas fa-car', text: '滴滴优惠券' },
            { icon: 'fas fa-map', text: '高德打车' }
        ],
        3: [ // 生活
            { icon: 'fas fa-coffee', text: '肯德基优惠' },
            { icon: 'fas fa-hamburger', text: '麦当劳优惠' }
        ]
    };
    
    tabs.forEach((tab, index) => {
        tab.addEventListener('click', function() {
            // Remove active class from all tabs
            tabs.forEach(t => t.classList.remove('active'));
            // Add active class to clicked tab
            this.classList.add('active');
            
            // Update content
            if (couponCards && tabContent[index]) {
                couponCards.innerHTML = '';
                tabContent[index].forEach(item => {
                    const card = document.createElement('div');
                    card.className = 'coupon-card';
                    card.innerHTML = `
                        <i class="${item.icon}"></i>
                        <span>${item.text}</span>
                        <button>领取</button>
                    `;
                    couponCards.appendChild(card);
                });
            }
        });
    });
});

// Download Button Click Handlers
document.addEventListener('DOMContentLoaded', function() {
    const androidBtn = document.querySelector('.download-btn.android');
    const iosBtn = document.querySelector('.download-btn.ios');
    
    if (androidBtn) {
        androidBtn.addEventListener('click', function(e) {
            e.preventDefault();
            // Here you would typically trigger the actual download
            alert('Android APK 下载功能即将开放，敬请期待！');
        });
    }
    
    if (iosBtn) {
        iosBtn.addEventListener('click', function(e) {
            e.preventDefault();
            alert('iOS 版本正在开发中，即将上线 App Store！');
        });
    }
});

// Contact Info Click Handlers
document.addEventListener('DOMContentLoaded', function() {
    const wechatContact = document.querySelector('.contact-item:first-child');
    
    if (wechatContact) {
        wechatContact.addEventListener('click', function() {
            // Copy WeChat ID to clipboard
            const wechatId = 'YourWeChatID';
            
            if (navigator.clipboard) {
                navigator.clipboard.writeText(wechatId).then(function() {
                    showNotification('微信号已复制到剪贴板: ' + wechatId);
                }).catch(function() {
                    showNotification('请手动复制微信号: ' + wechatId);
                });
            } else {
                // Fallback for older browsers
                const textArea = document.createElement('textarea');
                textArea.value = wechatId;
                document.body.appendChild(textArea);
                textArea.select();
                try {
                    document.execCommand('copy');
                    showNotification('微信号已复制到剪贴板: ' + wechatId);
                } catch (err) {
                    showNotification('请手动复制微信号: ' + wechatId);
                }
                document.body.removeChild(textArea);
            }
        });
    }
});

// Notification System
function showNotification(message, type = 'success') {
    // Remove existing notifications
    const existingNotifications = document.querySelectorAll('.notification');
    existingNotifications.forEach(notification => notification.remove());
    
    const notification = document.createElement('div');
    notification.className = `notification ${type}`;
    notification.textContent = message;
    
    // Styles
    notification.style.cssText = `
        position: fixed;
        top: 100px;
        right: 20px;
        background: ${type === 'success' ? '#4CAF50' : '#f44336'};
        color: white;
        padding: 1rem 1.5rem;
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        z-index: 10000;
        opacity: 0;
        transform: translateX(100%);
        transition: all 0.3s ease;
        max-width: 300px;
        word-wrap: break-word;
    `;
    
    document.body.appendChild(notification);
    
    // Animate in
    setTimeout(() => {
        notification.style.opacity = '1';
        notification.style.transform = 'translateX(0)';
    }, 100);
    
    // Animate out and remove
    setTimeout(() => {
        notification.style.opacity = '0';
        notification.style.transform = 'translateX(100%)';
        setTimeout(() => {
            if (notification.parentNode) {
                notification.parentNode.removeChild(notification);
            }
        }, 300);
    }, 3000);
}

// Lazy Loading for Images (if you add images later)
document.addEventListener('DOMContentLoaded', function() {
    const images = document.querySelectorAll('img[data-src]');
    
    const imageObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const img = entry.target;
                img.src = img.dataset.src;
                img.classList.remove('lazy');
                imageObserver.unobserve(img);
            }
        });
    });
    
    images.forEach(img => imageObserver.observe(img));
});

// Performance: Debounce scroll events
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

// Apply debounce to scroll handler
const debouncedScrollHandler = debounce(function() {
    const header = document.querySelector('.header');
    if (window.scrollY > 100) {
        header.style.background = 'rgba(255, 255, 255, 0.98)';
        header.style.boxShadow = '0 2px 20px rgba(0, 0, 0, 0.1)';
    } else {
        header.style.background = 'rgba(255, 255, 255, 0.95)';
        header.style.boxShadow = 'none';
    }
}, 10);

window.addEventListener('scroll', debouncedScrollHandler);
