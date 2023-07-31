# Toybox Laravel

<!-- TOC -->
* [Toybox Laravel](#toybox-laravel)
  * [Support](#support)
  * [Principles](#principles)
  * [Components](#components)
  * [Installation/Usage](#installationusage)
  * [Local Development](#local-development)
    * [macOS](#macos)
    * [Linux](#linux)
    * [Windows](#windows)
  * [Next Steps - DIY](#next-steps---diy)
    * [Services](#services)
      * [Mail Provider](#mail-provider-)
      * [Payment Provider](#payment-provider)
      * [Event tracking/system notifications](#event-trackingsystem-notifications)
      * [Uptime & Monitoring](#uptime--monitoring)
      * [Analytics](#analytics)
      * [Search](#search)
      * [Websockets](#websockets)
      * [Infrastructure/Server Management](#infrastructureserver-management)
        * [Serverless](#serverless)
        * [Desktop](#desktop)
    * [Other Tools](#other-tools)
      * [Laravel Octane](#laravel-octane)
        * [Roadrunner vs Swoole](#roadrunner-vs-swoole)
  * [Notes/Ideas](#notesideas)
  * [TODO](#todo)
<!-- TOC -->

My boilerplate for Laravel micro-SaaS/indie hackers.

The toybox has a bit of everything - a grand tour of the Laravel PHP world, so to speak.

> This project is intended mostly for use as a solo Laravel developer who wants to rapidly develop and deploy indie SaaS projects. For client work I'd still recommend going down more well-trodden paths like using Forge/Ploi or a Docker-based solution.

## Support

- [Buy me a coffee](https://tip-jar.co.za/@thecapegreek)
- Sign up to services like OhDear and Paystack with my affiliate links in the [Next Steps](#next-steps) section.
- I also [consult in the Laravel & payments space](https://nik.software)

## Principles

- **Be as self-contained as possible**: With minimal extra commands, you should be able to clone this repo and get something running.
- **Use the simplest form of each tool**: Minimising the different languages used, using simpler alternatives to common tools.
- **Verticality**: Use as much of the official Laravel ecosystem where applicable.
- **Customisable**: Don't like my tech choices? Shouldn't be too hard to sub the important ones out, e.g. SQLite -> MySQL.
- **Flexible, but sturdy**: Strict types. Automated linting.
- **Scaling should be simple**: It's cheaper to scale with load balancing & bigger servers than paying dev/ops salaries to overcomplicate your life with Docker, Kubernetes, etc. If your business needs all that, you should be able to afford it instead of using this.
- **Local is lekker**: Reducing reliance on third-party services for managing infrastructure, CI/CD, etc. while not reducing capabilities.
- **Don't reinvent the wheel**: More "performant" language ecosystems insist on having you write the same code for every standard feature. We don't do that here. At the same time we don't want to build an oversized swiss-army-knife of a system, or go too insane relying on third-party packages, so it's ideal to stick to well-used and understood packages that you will most likely need.

## Components

- **OS**: Your choice, but the main target here is [Ubuntu](https://ubuntu.com/).
- **Webserver**: [Caddy](https://caddyserver.com/) - with the Laravel application running with [Octane](https://laravel.com/docs/10.x/octane)
- **Database**: Your choice. Default setup is for [SQLite](https://www.sqlite.org/index.html)
- **Cache & Queues**: [Redis](https://redis.io)
- **Application**: [Laravel](https://laravel.com) (duh)
  - **Authentication**: [Laravel Breeze](https://laravel.com/docs/10.x/starter-kits#laravel-breeze) 
  - **Frontend**: [Livewire](https://livewire.laravel.com), including [Alpine.js](https://alpinejs.dev/).
  - **Admin panel**: [Filament](https://filamentphp.com/)
  - **API**: [Laravel Sanctum](https://laravel.com/docs/10.x/sanctum) 
  - **Testing**: [PestPHP](https://pestphp.com/)
  - **Linting**: [Duster](https://github.com/tighten/duster) (includes Laravel Pint) - Minor Pint config changes based on personal style preference, and strict types everywhere.
  - **Observability/Metrics**: [Laravel Telescope](https://laravel.com/docs/10.x/telescope) and [Horizon](https://laravel.com/docs/10.x/horizon)
- **CI/CD**: [Deployer](https://deployer.org/)

## Installation/Usage

This assumes you're starting from scratch on an unmanaged (no Forge/Ploi/Envoyer) Ubuntu server.

Why Ubuntu? It's a popular OS and a relatively stable target for most use cases.

First, update apt, then install some dependencies, and install PHP 8.2 using the Ondrej PPA, and then the required extensions.

```shell
sudo apt update
sudo apt install -y lsb-release gnupg2 ca-certificates apt-transport-https software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install php8.2
sudo apt install php8.2-curl php8.2-dom php8.2-mbstring php8.2-xml php8.2-sqlite3 php8.2-mysql
```

Then, run the setup script to set up pre-commit linting, composer & npm, SQLite database init, create the .env file and application key.

```shell
./setup.sh
```

From there modify your .env file as needed.

Now, setting up Supervisor to run all the services:
```shell
# TODO
```

Next, setting up the Caddy server:

```shell
# TODO
```

## Local Development

In keeping with the spirit of this project, try using native solutions. One drawback here is that Valet and Herd don't use Octane.

### macOS

- ([Valet](https://laravel.com/docs/10.x/valet) & [PHPMon](https://phpmon.app/)) OR [Laravel Herd](https://herd.laravel.com/)
- [DBngin](https://dbngin.com/)

### Linux

- [Valet Linux](https://cpriego.github.io/valet-linux/) OR install PHP manually.
- Install your DB of choice locally

### Windows

Follow Linux instructions on WSL2. Not sure all of it will work properly though, I don't use Windows.

## Next Steps - DIY

These are the next steps you will have to implement yourself for your project.

### Services

#### Mail Provider 

[Laravel recommends](https://laravel.com/docs/10.x/mail#introduction) [Mailgun](https://www.mailgun.com/), [Postmark](https://postmarkapp.com/) and [SES](https://aws.amazon.com/ses/). Another option that integrates well, and works for newsletters/marketing campaigns too, is [Mailcoach](https://mailcoach.app/).
 
#### Payment Provider

There are a few options here, depending on your region. For many countries, [Stripe](https://stripe.com) with [Laravel Cashier](https://laravel.com/docs/10.x/billing#introduction) will be fine. Otherwise, have a look at [Paddle](https://www.paddle.com/) (also has a [Cashier plugin](https://laravel.com/docs/10.x/cashier-paddle)) or [Lemon Squeezy](https://lemonsqueezy.com) (Laravel package [here](https://github.com/lmsqueezy/laravel)) for a Merchant of Record. 

If you're in Africa, [Paystack](https://paystack.com/) is a solid option (affiliate signup: [here](https://nik-software.paystack.com/#/signup)). 

For more options, and whether or not you need an MoR, and taxation info see [here](https://writing.nikspyratos.com/Perceptions/Ambition+-+Careers+-+Entrepreneurship/Resources/Payment+Gateways).

#### Event tracking/system notifications

I recommend [LogSnag](https://logsnag.com/).
#### Uptime & Monitoring

I recommend [OhDear](https://ohdear.app/?via=nikspyratos).

#### Analytics

[Fathom](https://usefathom.com) and [Plausible](https://plausible.io) are great options. If I had to choose: Fathom has more accessible pricing, and is made with Laravel!

#### Search

[Algolia](https://www.algolia.com/) and [Meilisearch](https://www.meilisearch.com) are the ones supported by [Laravel Scout](https://laravel.com/docs/10.x/scout). Meilisearch can be self-hosted, but can be a handful to manage and would still cost a fair bit in storage/RAM requirements, so you might not save much in time & headaches over using cloud.

#### Websockets

[Pusher](https://pusher.com) and [Ably](https://ably.com) are great paid options in this space, which will be used alongside [Laravel Echo](https://laravel.com/docs/10.x/broadcasting#client-side-installation). If you want to DIY, see [below](#other-tools).

#### Infrastructure/Server Management

[Laravel Forge](https://forge.laravel.com/) and [Ploi](https://ploi.io/) are good options (I prefer Ploi) and support many cloud providers. I lean towards AWS, but only because they have a Cape Town region.

##### Serverless

Either [Laravel Vapor](https://vapor.laravel.com/) or roll-your-own setup for free with [Bref](https://bref.sh/). While this boilerplate is untested with Serverless, I still wanted to provide some links.

##### Desktop

While still in alpha, [NativePHP](https://nativephp.com/) will hopefully be a very promising option if you'd like to add desktop apps to your toolkit.

---

### Other Tools

- **APIs**
  - **Consuming APIs**: I recommend [Saloon](https://docs.saloon.dev/) - it can be a bit overkill for small APIs, but it really helps with structuring logic with larger APIs and OAuth. I use it as the base for my [Investec Banking API SDK](https://github.com/nikspyratos/investec-sdk-php). 
  - **OpenAPI/Swagger**: [l5-swagger](https://github.com/DarkaOnLine/L5-Swagger) is great here - must-use for writing great APIs.
  - **Data Transfer Objects**: [Laravel Data](https://spatie.be/docs/laravel-data/v3/introduction) should cover you, but if you want something simple and non-Laravel, [dragon-code/simple-dto](https://github.com/TheDragonCode/simple-data-transfer-object) does the job without much overhead. 
- **Excel Import/Export**: [Laravel Excel](https://docs.laravel-excel.com/3.1/getting-started/) - it's a wrapper over PHPSpreadsheet, very convenient.
- **More Laravel goodies**: [Social login](https://laravel.com/docs/10.x/socialite), [Feature Flags](https://laravel.com/docs/10.x/pennant), [OAuth2](https://laravel.com/docs/10.x/passport), [Search](https://laravel.com/docs/10.x/scout), [Websockets](https://beyondco.de/docs/laravel-websockets/getting-started/introduction) (and [client](https://laravel.com/docs/10.x/broadcasting#client-side-installation)). 

For more niche suggestions and general Laravel resources, check out my [Laravel links page](https://writing.nikspyratos.com/Perceptions/Learning/Resources/Tech/Laravel).

#### Laravel Octane

By default, this project runs with Laravel Octane using Roadrunner. This lets the application run faster than traditionally with php-fpm. 
There is one main drawback however, in that many packages in the ecosystem are not made with a concurrent/shared-memory model in mind. This opens up the potential for memory leaks. At the same time, the purported speed boost offered I think is not to be ignored.

The longer we hold back from using these tools because of dependencies, the longer it will take for them to become viable. Stay vigilant of your app's memory usage, and submit PRs to your dependencies if you find leaks.

If you instead want to remove Octane:
1. Remove the package, config file, and Roadrunner:
```shell
composer remove laravel/octane
rm config/octane.php
rm rr
rm .rr.yaml
```
2. Install PHP-FPM
```shell
sudo apt install php8.2-fpm
```
3. Switch Caddy to use FPM: Replace the `reverse_proxy` line in your Caddyfile with `php_fastcgi unix//run/php/php8.2-fpm.sock`

##### Roadrunner vs Swoole

In short:
- Roadrunner is a Go-based PHP application server
- Swoole is a PHP _extension_ that adds functionality to PHP in the form of concurrent tasks.
  - Swoole itself is split between [OG Swoole](https://www.swoole.com/) and [OpenSwoole](https://openswoole.com) after [some drama](https://github.com/swoole/swoole-src/issues/4450). Going by commit history, it seems Swoole is more active than OpenSwoole.

I haven't been able to find more recent [benchmarks](https://github.com/morozovsk/webserver-performance-comparison), but it seems the general implication is that Swoole is faster than Roadrunner.

Roadrunner is simpler, but Swoole provides a lot more functionality to your Octane with [concurrent tasks](https://laravel.com/docs/10.x/octane#concurrent-tasks), [ticks & intervals](https://laravel.com/docs/10.x/octane#ticks-and-intervals), the [octane cache](https://laravel.com/docs/10.x/octane#the-octane-cache), and [tables](https://laravel.com/docs/10.x/octane#tables). Additionally, it seems Swoole doesn't play well with debug extensions and monitoring applications (hopefully that's changed since 2021).

Installing Octane with Roadrunner:
1. Select `roadrunner` when running `php artisan octane:install`
2. Roadrunner will be downloaded and run when you run Octane. No further action needed past that selection.

Installing Octane with Swoole:
1. Run the following
```shell
# Swoole is available in the Ondřej Surý PPA
sudo apt install php8.2-swoole
# OpenSwoole
sudo add-apt-repository ppa:openswoole/ppa -y
sudo apt install -y php8.2-openswoole
```
2. Select `swoole` when running `php artisan octane:install`.

Switching between Roadrunner and Swoole is simple:
1. Follow the Swoole steps above.
2. Update your `OCTANE_SERVER` env or your `config/octane.php`'s `server` key to `swoole`, and restart Octane.

## Notes/Ideas

- Caddy usage here may be of limited use for you if you use Forge/Ploi/etc.
- Redis is a part of this stack, but filesystem cache & `php artisan queue:work` can probably do just fine for quite a while. However the Horizon integration for visibility is really nice.
- Should tests run as pre-commit hooks too? On larger test bases and for atomised commits probably a bad idea, so for now no.
- Laravel Folio for non-application pages? E.g. landing page
- More general Filament component usage outside of admin panel
- CI/CD: Github Actions could be used for testing on PRs/main pushes. For a more local alternative, perhaps a pre-push hook to prevent push if tests fail?
- Docker: Support not yet planned. One big issue is Deployer doesn't play very well with it - you'd have to enable SSH access directly into the container to do anything. I also think the most ideal version would be a multi-service container.

## TODO

- Installation docs
- Get something working with this
- Livewire + Filament v3
- Filament: Get vite/tailwind config setup for colour customisation
- Deployer: 
  - Set up for deployment without storing credentials/IPs in the repo. Also would like to use the yaml style more but the doc examples are focused on the PHP version too much.
  - Rolling release setup
- Supervisor for managing all the different pieces?
- Test multi-server version of this
