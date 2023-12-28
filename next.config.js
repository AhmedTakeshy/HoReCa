/** @type {import('next').NextConfig} */
const nextConfig = {
    images:{
        remotePatterns:[
            {
                protocol: "https",
                hostname: "n11scdn.akamaized.net",
            },
        ],
    }
}

module.exports = nextConfig
