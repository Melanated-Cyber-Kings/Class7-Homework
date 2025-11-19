#!/bin/bash
# Use this for your user data (script from top to bottom)
# install httpd (Linux 2 version)
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Get the IMDSv2 token
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Background the curl requests
curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/local-ipv4 &> /tmp/local_ipv4 &
curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/placement/availability-zone &> /tmp/az &
curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/ &> /tmp/macid &
wait

macid=$(cat /tmp/macid)
local_ipv4=$(cat /tmp/local_ipv4)
az=$(cat /tmp/az)
vpc=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/${macid}/vpc-id)

# Get hostname
hostname_value=$(hostname -f)

cat > /var/www/html/index.html << EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CouchtoCloud: The Art of Living</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600&family=Space+Mono:wght@400;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #0f0f0f;
            --secondary-color: #1a1a1a;
            --accent-color: #d4af37; /* Gold */
            --text-color: #e0e0e0;
            --muted-text: #888;
            --font-main: 'Montserrat', sans-serif;
            --font-tech: 'Space Mono', monospace;
            --transition-speed: 0.6s;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        
        body {
            font-family: var(--font-main);
            background-color: var(--primary-color);
            color: var(--text-color);
            line-height: 1.6;
            overflow-x: hidden;
        }

        /* --- Hero Section --- */
        .hero {
            height: 100vh;
            background-image: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.8)), url('https://i.ibb.co/HpCVj8LM/houseinthehills1.webp');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 0 2rem;
            animation: fadeIn 2s ease-in-out;
        }

        .hero h1 {
            font-size: 3.5rem;
            font-weight: 300;
            letter-spacing: 4px;
            text-transform: uppercase;
            margin-bottom: 1.5rem;
            border-bottom: 1px solid var(--accent-color);
            padding-bottom: 1rem;
        }

        .hero p {
            font-size: 1.2rem;
            font-weight: 300;
            max-width: 700px;
            color: var(--muted-text);
        }

        /* --- Content  --- */
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding-bottom: 4rem;
        }

        .section {
            padding: 8rem 2rem;
            opacity: 0;
            transform: translateY(50px);
            transition: all var(--transition-speed) cubic-bezier(0.25, 0.46, 0.45, 0.94);
        }

        .section.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .section-title {
            text-align: center;
            font-size: 2rem;
            text-transform: uppercase;
            letter-spacing: 6px;
            margin-bottom: 4rem;
            color: var(--accent-color);
        }

        /* --- Grid System --- */
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 2.5rem;
        }

        .card {
            background-color: var(--secondary-color);
            border-radius: 4px; 
            overflow: hidden;
            box-shadow: 0 20px 50px rgba(0,0,0,0.3);
            transition: transform 0.4s ease, box-shadow 0.4s ease;
            position: relative;
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 30px 60px rgba(212, 175, 55, 0.1); /* Subtle gold  */
        }

        .card-image-wrapper {
            overflow: hidden;
            height: 400px;
        }

        .card img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.8s ease;
        }

        .card:hover img {
            transform: scale(1.05);
        }

        .card-content {
            padding: 2rem;
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            background: linear-gradient(to top, rgba(0,0,0,0.9), rgba(0,0,0,0));
        }

        .card h3 {
            font-size: 1.4rem;
            font-weight: 500;
            letter-spacing: 2px;
            margin-bottom: 0.5rem;
            color: #fff;
        }

        /* --- Parallax  --- */
        .parallax {
            min-height: 500px;
            background-image: url('https://i.ibb.co/ycrYdwc9/porsche-911-gt3-r-rennsport-2023-rear.jpg');
            background-attachment: fixed;
            background-position: center;
            background-repeat: no-repeat;
            background-size: cover;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 4rem 0;
        }

        .parallax-content {
            background: rgba(0, 0, 0, 0.7);
            padding: 3rem 5rem;
            border: 1px solid var(--accent-color);
            backdrop-filter: blur(5px);
        }

        .parallax-content h2 {
            font-size: 2.5rem;
            font-weight: 300;
            letter-spacing: 3px;
        }

        /* --- Technical Info  --- */
        .telemetry-footer {
            background-color: #050505;
            border-top: 1px solid #333;
            padding: 4rem 2rem;
            margin-top: 4rem;
            font-family: var(--font-tech);
        }

        .telemetry-grid {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 2rem;
            text-align: center;
        }

        .telemetry-item {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .telemetry-label {
            color: var(--muted-text);
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .telemetry-value {
            color: var(--accent-color);
            font-size: 1.1rem;
            font-weight: 700;
            text-shadow: 0 0 10px rgba(212, 175, 55, 0.3);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            .hero h1 { font-size: 2rem; }
            .card-image-wrapper { height: 300px; }
            .telemetry-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>

    <header class="hero">
        <h1>Cloud Certified</h1>
        <p>Automated infrastructure. Globally distributed assets. Uncompromising lifestyle.</p>
    </header>

    <div class="container">
        
        <section class="section">
            <h2 class="section-title">Global Inspirations</h2>
            <div class="grid">
                <div class="card">
                    <div class="card-image-wrapper">
                        <img src="https://i.ibb.co/FkxPQMDQ/wifecandidate1.png" alt="Brazil">
                    </div>
                    <div class="card-content">
                        <h3>Brazil</h3>
                    </div>
                </div>
                <div class="card">
                    <div class="card-image-wrapper">
                        <img src="https://i.ibb.co/ynV4Kd9j/colombia.png" alt="Colombia">
                    </div>
                    <div class="card-content">
                        <h3>Colombia</h3>
                    </div>
                </div>
                <div class="card">
                    <div class="card-image-wrapper">
                        <img src="https://i.ibb.co/vvwDQMpF/u3633825151-cinematic-fashion-editorial-photograph-of-an-except-611d60bb-84c2-413e-9f05-5e8a62edb8e7.png" alt="Japan">
                    </div>
                    <div class="card-content">
                        <h3>Japan</h3>
                    </div>
                </div>
            </div>
        </section>

    </div>

    <!-- Parallax  -->
    <div class="parallax">
        <div class="parallax-content">
            <h2>Internationally Verified</h2>
        </div>
    </div>

    <!-- Instance Stats -->
    <footer class="telemetry-footer">
        <div class="telemetry-grid">
            <div class="telemetry-item">
                <span class="telemetry-label">Instance Hostname</span>
                <span class="telemetry-value">$(hostname -f)</span>
            </div>
            <div class="telemetry-item">
                <span class="telemetry-label">Private IP</span>
                <span class="telemetry-value">${local_ipv4}</span>
            </div>
            <div class="telemetry-item">
                <span class="telemetry-label">Availability Zone</span>
                <span class="telemetry-value">${az}</span>
            </div>
            <div class="telemetry-item">
                <span class="telemetry-label">VPC Network</span>
                <span class="telemetry-value">${vpc}</span>
            </div>
        </div>
    </footer>

    <script>
        /* --- Scroll Animation --- */
        document.addEventListener('DOMContentLoaded', () => {
            const sections = document.querySelectorAll('.section');
            
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('visible');
                    }
                });
            }, { threshold: 0.1 });

            sections.forEach(section => observer.observe(section));
        });
    </script>

</body>
</html>
EOF

# Clean up the temp files
rm -f /tmp/local_ipv4 /tmp/az /tmp/macid