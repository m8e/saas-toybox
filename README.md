# Toybox Laravel

<!-- TOC -->
* [Toybox Laravel](#toybox-laravel)
  * [Support this project](#support-this-project)
  * [Principles](#principles)
  * [Components](#components)
  * [Installation/Usage](#installationusage)
    * [Local Development](#local-development)
      * [macOS](#macos)
      * [Linux](#linux)
      * [Windows](#windows)
    * [Production](#production)
  * [Next Steps - DIY](#next-steps---diy)
    * [Post-Setup](#post-setup)
    * [3rd-party Services/Tools](#3rd-party-servicestools)
      * [CMS](#cms)
      * [Media Library](#media-library)
      * [File Storage](#file-storage)
      * [Mail Provider](#mail-provider-)
      * [Payment Provider](#payment-provider)
      * [Event tracking/system notifications](#event-trackingsystem-notifications)
      * [Uptime & Monitoring](#uptime--monitoring)
      * [Analytics](#analytics)
      * [Data Analysis](#data-analysis)
      * [Search](#search)
      * [Websockets](#websockets)
      * [Infrastructure](#infrastructure)
      * [Backups](#backups)
      * [Serverless](#serverless)
      * [Desktop](#desktop)
      * [Mobile](#mobile)
    * [Other Tools not included](#other-tools-not-included)
      * [Filament Plugins & Tricks](#filament-plugins--tricks)
    * [Switching to MySQL/Postgres](#switching-to-mysqlpostgres)
    * [Laravel Octane](#laravel-octane)
      * [Roadrunner vs Swoole](#roadrunner-vs-swoole)
  * [Notes](#notes)
  * [What to do when you need to scale](#what-to-do-when-you-need-to-scale)
  * [Other recommendations for business operations, launching, etc.](#other-recommendations-for-business-operations-launching-etc)
    * [Helpdesk/Support](#helpdesksupport)
    * [Live Chat](#live-chat)
    * [Knowledgebase](#knowledgebase)
    * [Accounting](#accounting)
    * [Terms & Conditions](#terms--conditions)
  * [TODO](#todo)
<!-- TOC -->

My TALL stack boilerplate for Laravel micro-SaaS/indie hackers.

The toybox has a bit of everything - a grand tour of the Laravel PHP world, so to speak.

Even if you don't need another boilerplate, perhaps the list of [recommended services](#next-steps---diy) will still give you a path forward.

While this is an opinionated setup, it's easy to change it as you please.

> This project is intended mostly for use as a solo Laravel developer who wants to rapidly develop and deploy indie SaaS projects. This is not intended for junior developers - having worked with the modern Laravel ecosystem is ideal to use this project. For client work I'd still recommend going down more well-trodden paths like using Forge/Ploi or a Docker-based solution.

## Support this project

- [Buy me a coffee](https://tip-jar.co.za/@thecapegreek)
- Sign up to services like OhDear and Paystack with my affiliate links in the [Next Steps](#next-steps---diy) section.
- I also [consult in the Laravel & payments space](https://nik.software)

## Principles

- **Be as self-contained as possible**: With minimal extra commands, you should be able to clone this repo and get something running.
- **Use the simplest form of each tool**: Minimising the different languages used, using simpler alternatives to common tools.
- **Verticality**: Use as much of the official & unofficial Laravel ecosystem where applicable.
- **Customisable**: Don't like my tech choices? Shouldn't be too hard to sub the important ones out, e.g. SQLite -> MySQL, PHP-FPM -> Octane.
- **Flexible, but sturdy**: Strict types. Automated linting.
- **Scaling should be simple**: It's cheaper to scale with load balancing & bigger servers than paying dev/ops salaries to overcomplicate your life with Docker, Kubernetes, etc. If your business needs all that, you should be able to afford it instead of using this.
- **Local is lekker**: Reducing reliance on third-party services for managing infrastructure, CI/CD, etc. while not reducing capabilities.
- **Don't reinvent the wheel**: More "performant" language ecosystems insist on having you write the same code for every standard feature. We don't do that here. At the same time we don't want to build an oversized swiss-army-knife of a system, or go too insane relying on third-party packages, so it's ideal to stick to well-used and understood packages that you will most likely need.

## Components

- **OS**: Your choice, but the main target here is [Ubuntu](https://ubuntu.com/).
- **Webserver**: [Caddy](https://caddyserver.com/)
- **Database**: Your choice. The default setup is for [SQLite](https://www.sqlite.org/index.html)
- **Cache, Queues, Session, Websockets**: [Redis](https://redis.io).
- **Application**: [Laravel](https://laravel.com) (duh)
  - **Authentication**: [Laravel Breeze](https://laravel.com/docs/10.x/starter-kits#laravel-breeze) 
  - **Frontend**: [Livewire](https://livewire.laravel.com) (including [Alpine.js](https://alpinejs.dev/)), and [Laravel SEO](https://github.com/ralphjsmit/laravel-seo).
  - **Admin panel**: [Filament](https://filamentphp.com/), with included plugins:
    - [Environment Indicator](https://filamentphp.com/plugins/pxlrbt-environment-indicator)
    - [Laravel Filament SEO](https://github.com/ralphjsmit/laravel-filament-seo)
    - [Filament Laravel Health](https://filamentphp.com/plugins/shuvroroy-spatie-laravel-health)
    - [Activity Log](https://filamentphp.com/plugins/pxlrbt-activity-log)
  - **API**: [Laravel Sanctum](https://laravel.com/docs/10.x/sanctum) 
  - **Testing**: [PestPHP](https://pestphp.com/)
  - **Linting**: [Duster](https://github.com/tighten/duster) (includes Laravel Pint) - Minor Pint config changes based on personal style preference, and strict types everywhere.
  - **Observability/Metrics**: [Laravel Telescope](https://laravel.com/docs/10.x/telescope), [Horizon](https://laravel.com/docs/10.x/horizon), and [Laravel Health](https://spatie.be/docs/laravel-health/v1/introduction)
- **CI/CD**: Good old Bash scripts.

## Installation/Usage

### Local Development

In keeping with the spirit of this project, try using native solutions. One drawback here is that Valet and Herd don't use Octane, if you use that.

Once you've set up one of the methods below, run `./bin/init_dev.sh` to set up pre-commit linting, replace template names, and do Laravel boilerplate setup (package installs, key generate, migrate, etc.). All you need to do is modify your `.env` as needed.

For details, look in [bin/init_dev.sh](bin/init_dev.sh).

#### macOS

- ([Valet](https://laravel.com/docs/10.x/valet) & [PHPMon](https://phpmon.app/)) OR [Laravel Herd](https://herd.laravel.com/)
- [DBngin](https://dbngin.com/)

#### Linux

- [Valet Linux](https://cpriego.github.io/valet-linux/) OR install PHP manually.
- Install your DB of choice locally

#### Windows

Follow Linux instructions on WSL2. Not sure all of it will work properly though, I don't use Windows.

### Production

This assumes you're starting from scratch on an unmanaged (no Forge/Ploi/Envoyer) Ubuntu server.

Why Ubuntu? It's a popular OS and a relatively stable target for most use cases.

Your first step is to download your project repository from your VCS. Then, run `./bin/setup_prod.sh` from the project directory. It will:
- Install PHP (and extensions), Caddy, Redis, and Supervisor
- Setup Caddy to run your Caddyfile
- Install the Horizon config for Supervisor
- Setup your app (composer & npm install, key generate, migrate, install crontab, etc.). All you need to do is modify your `.env` as needed.

For details, look in [bin/provision_prod.sh](bin/provision_prod.sh).

## Next Steps - DIY

These are the next steps you will have to implement yourself for your project as your needs change & scale.

### Post-Setup

- **Laravel SEO**: Consult the [main package documentation](https://github.com/ralphjsmit/laravel-seo) as well as the [Filament plugin](https://github.com/ralphjsmit/laravel-filament-seo) on how to handle SEO for your models.
- **Laravel Health**: 
  - If using MySQL or Postgres, consider adding the [Database Connections](https://spatie.be/docs/laravel-health/v1/available-checks/db-connection-count), [Database Size](https://spatie.be/docs/laravel-health/v1/available-checks/db-size-check), and [Database table size](https://spatie.be/docs/laravel-health/v1/available-checks/db-table-size-check) healthchecks. 
  - If using Flare, consider adding the [Flare Error Count](https://spatie.be/docs/laravel-health/v1/available-checks/flare-error-count) healthcheck.
  - If using Meilisearch, consider adding the [Meilisearch](https://spatie.be/docs/laravel-health/v1/available-checks/meilisearch) healthcheck.
  - For pinging any other services (e.g. to test network or other services for health), you can add the [Ping](https://spatie.be/docs/laravel-health/v1/available-checks/ping) healthcheck.
  - If you have multiple queues, you can modify the [Queue](https://spatie.be/docs/laravel-health/v1/available-checks/queue) healthcheck accordingly.
  - To monitor a specific Redis connection, [you can specify the name](https://spatie.be/docs/laravel-health/v1/available-checks/redis#content-customizing-the-thresholds).
  - If you want to monitor _specific_ scheduled jobs, consider installing [spatie/laravel-schedule-monitor](https://github.com/spatie/laravel-schedule-monitor).
- **Laravel Activity log**: Consult the [documentation](https://spatie.be/docs/laravel-activitylog/v4/introduction) to begin logging user activity for analytics.
- **Landing page/CMS**: Assuming these pages are static, make sure they are heavily cached.
- **Queues**: Consult the [Horizon](https://laravel.com/docs/10.x/horizon) documentation on how best to use it for your queues.

---

### 3rd-party Services/Tools

**Remember: this is a list of options, not requirements. You can likely run your SaaS perfectly fine without many of these.**

#### CMS

[Statamic](https://statamic.com/) has excellent integration directly into Laravel apps.

Alternatively, there are plenty of other blog/content site providers out there, e.g. [Wordpress](https://wordpress.org/). The CMS space is too huge to make any more specific recommendations.

If you want something free & simple for creating content for your app, consider using [Jigsaw](https://jigsaw.tighten.com/) - a static site generator that uses Markdown & Blade. It's free and easy to use. If hosting it with Github Pages, have a look [here](https://github.com/nikspyratos/thecapegreek-site/blob/master/bin/deploy) on how to remove build artifacts from your main branch.

#### Media Library

Spatie's [Media Library Pro](https://medialibrary.pro/) is excellent. See [below](#other-tools-not-included) for free version details.

#### File Storage

Consider using any [S3-compatible storage service](https://gprivate.com/663g4). The ordinary local disk may be enough for your use case, but it may be prudent to separate this from your app. That way if you don't need a big server but need lots of storage, you don't have to scale your server costs unnecessarily (storage is much cheaper!). 

#### Mail Provider 

[Laravel recommends](https://laravel.com/docs/10.x/mail#introduction) [Mailgun](https://www.mailgun.com/), [Postmark](https://postmarkapp.com/) and [SES](https://aws.amazon.com/ses/). Another option that integrates well, and works for newsletters/marketing campaigns too, is [Mailcoach](https://mailcoach.app/).
 
#### Payment Provider

There are a few options here, depending on your region. For many countries, [Stripe](https://stripe.com) with [Laravel Cashier](https://laravel.com/docs/10.x/billing#introduction) will be fine. Otherwise, have a look at [Paddle](https://www.paddle.com/) (also has a [Cashier plugin](https://laravel.com/docs/10.x/cashier-paddle)) or [Lemon Squeezy](https://lemonsqueezy.com) (Laravel package [here](https://github.com/lmsqueezy/laravel)) for a Merchant of Record. 

If you're in Africa, [Paystack](https://paystack.com/) is a solid option (affiliate signup: [here](https://nik-software.paystack.com/#/signup)). 

For more options, and whether or not you need an MoR, and taxation info see [here](https://writing.nikspyratos.com/Perceptions/Ambition+-+Careers+-+Entrepreneurship/Resources/Payment+Gateways).

#### Event tracking/system notifications

I recommend [LogSnag](https://logsnag.com/).

#### Uptime & Monitoring

I recommend [OhDear](https://ohdear.app/?via=nikspyratos). For error monitoring, [Flare](https://flareapp.io) is also good.

#### Analytics

[Fathom](https://usefathom.com) and [Plausible](https://plausible.io) are great options. If I had to choose: Fathom has more accessible pricing, and is made with Laravel!

#### Data Analysis

I highly recommend checking out [Metabase](https://metabase.com) for this. While it's fairly simple to make graphs/dashboards and track database metrics with Laravel/Filament, Metabase is more specialised for the task and separates concerns nicely. It can also be self-hosted!.

#### Search

[Algolia](https://www.algolia.com/) and [Meilisearch](https://www.meilisearch.com) are the ones supported by [Laravel Scout](https://laravel.com/docs/10.x/scout). Meilisearch can be self-hosted, but can be a handful to manage and would still cost a fair bit in storage/RAM requirements, so you might not save much in time & headaches over using cloud.

#### Websockets

[Pusher](https://pusher.com) and [Ably](https://ably.com) are great paid options in this space, which will be used alongside [Laravel Echo](https://laravel.com/docs/10.x/broadcasting#client-side-installation). If you want to DIY, see [below](#other-tools-not-included).

#### Infrastructure

[Laravel Forge](https://forge.laravel.com/) and [Ploi](https://ploi.io/) are good options (I prefer Ploi) and support many cloud providers. I lean towards AWS, but only because they have a Cape Town region.

#### Backups

- SQLite: [LiteStream](https://litestream.io/)
- MySQL, volumes, servers, and more: [SnapShooter](https://snapshooter.com/)

#### Serverless

Either [Laravel Vapor](https://vapor.laravel.com/) or roll-your-own setup for free with [Bref](https://bref.sh/). **Note**: this project is untested with serverless. If you get it working with any modifications, make a PR for adding your setup or instructions!

#### Desktop

While still in alpha, [NativePHP](https://nativephp.com/) will hopefully be a very promising option if you'd like to add desktop apps to your toolkit.

#### Mobile

Yeah, nah. Maybe some mad scientist has gotten this one right, but I'd recommend sticking to "normal" mobile tech.

---

### Other Tools not included

- **APIs**
  - **Consuming APIs**: I recommend [Saloon](https://docs.saloon.dev/) - it can be a bit overkill for small APIs, but it really helps with structuring logic with larger APIs and OAuth. I use it as the base for my [Investec Banking API SDK](https://github.com/nikspyratos/investec-sdk-php). 
  - **OpenAPI/Swagger**: [l5-swagger](https://github.com/DarkaOnLine/L5-Swagger) is great here - must-use for writing great APIs. Otherwise, [Scramble](https://scramble.dedoc.co/) is a new entry in the scene.
  - **Data Transfer Objects**: [Laravel Data](https://spatie.be/docs/laravel-data/v3/introduction) should cover you, but if you want something simple and non-Laravel, [dragon-code/simple-dto](https://github.com/TheDragonCode/simple-data-transfer-object) does the job without much overhead. 
- **Excel Import/Export**: [Laravel Excel](https://docs.laravel-excel.com/3.1/getting-started/) - it's a wrapper over PHPSpreadsheet, very convenient. For exports from Filament tables, there's also [Filament Excel](https://github.com/pxlrbt/filament-excel) which uses Laravel Excel under the hood.
- **More Laravel goodies**: [Social login](https://laravel.com/docs/10.x/socialite), [Feature Flags](https://laravel.com/docs/10.x/pennant), [OAuth2](https://laravel.com/docs/10.x/passport), [Search](https://laravel.com/docs/10.x/scout), [Websockets](https://beyondco.de/docs/laravel-websockets/getting-started/introduction) (and [client](https://laravel.com/docs/10.x/broadcasting#client-side-installation)).
- **Manual backups**: [Laravel Backup](https://github.com/spatie/laravel-backup) (with [Filament plugin](https://filamentphp.com/plugins/shuvroroy-spatie-laravel-backup)). If using SQLite you can just do a file download of your database with the `Storage` facade.
- **2FA, Password reset, token management**: For more secure access to admin panels, consider adding [Filament Breezy](https://filamentphp.com/plugins/jeffgreco-breezy). Especially useful if you have a customer-facing Filament panel.
- **Media Management**: Try out [Spatie Media Library](https://spatie.be/docs/laravel-medialibrary/v10/introduction) alongside [Filament's plugin](https://filamentphp.com/plugins/filament-spatie-media-library).
- **Alternative Eloquent Drivers**: [Sushi](https://github.com/calebporzio/sushi) is an array driver, while [Orbit](https://github.com/ryangjchandler/orbit) is a flat file driver. These can be useful for things like CMSes, or loading data into Filament tables (which rely on the Eloquent query builder) without needing a database-driven model.
- **Provisioning & Deployment**: [Deployer](https://deployer.org/).

For more niche suggestions and general Laravel resources, check out my [Laravel links page](https://writing.nikspyratos.com/Perceptions/Learning/Resources/Tech/Laravel).

For more tutorials, packages and more, make sure to look at [Laravel News](https://laravel-news.com/).

#### Filament Plugins & Tricks

This boilerplate relies heavily on FilamentPHP for the admin panel building. This also means there are plenty of extra resources to augment either your UI or admin panel:
- [Plugins](https://filamentphp.com/plugins)
- [Community Articles](https://filamentphp.com/community)

---

### Switching to MySQL/Postgres

If you prefer to use MySQL/Postgres, there are some things to be aware of:
- The Database download action in `Filament\Pages\HealthCheckResults` will need to be modified to do a dump of the database. It may be preferrable to delete this action and use [Laravel backup Filament](https://filamentphp.com/plugins/shuvroroy-spatie-laravel-backup) instead.

### Laravel Octane

Initially, this project included Laravel Octane. I love the idea of it - an almost free speed boost, and with Swoole even a free cache! 

After some consideration and discussion on the topic, I've decided not to include it. The shared-memory model introduced with the Octane paradigm is a footgun - even if your own code is clean, you can't always trust your dependencies to not introduce memory leaks.

If you need to speed up or scale your application workload, consider horizontal & vertical scaling of your server(s) first. Then when you want to squeeze some extra juice, consider Octane.

The longer we hold back from using these tools because of dependencies, the longer it will take for them to become viable. Stay vigilant of your app's memory usage, and submit PRs to your dependencies if you find leaks.

Switching to using Octane is fairly simple on your own server. I'm not sure how easy this is to do on Forge/Ploi and have them manage it properly, so it may be smarter to just provision a new server entirely.
1. Follow the [setup instructions](https://laravel.com/docs/10.x/octane), 
2. Set up Octane to run as a service or with supervisor on your server.
3. Replace the `reverse_proxy` line in your Caddyfile with `reverse_proxy 127.0.0.1:8000` (or whichever port you run it on).

#### Roadrunner vs Swoole

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
1. Run the following:
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

## Notes

- Many of the Filament packages used are nascent and subject to breakage. I'll try and keep everything up to date on a best-effort basis, or remove packages that refuse to update/end up abandoned.
- There's a bit of admitted hypocrisy here: Using SQLite for simplicity over running MySQL, but at the same time using Redis for queue & cache. Should Redis be removed, or should MySQL be added?
  - Filesystem cache & `php artisan queue:work` can probably do just fine for quite a while. 
  - The Horizon integration for visibility into queues is really nice.
- Should tests run as pre-commit hooks too? On larger test bases and for atomised commits probably a bad idea, so for now no.
- CI/CD: Github Actions could be used for testing on PRs/main pushes. For a more local alternative, perhaps a pre-push hook to prevent push if tests fail?
- Docker: Support not yet planned.

## What to do when you need to scale

This package is a starting point, but as your project scales, you may need to add some more pieces to keep it stable & safe.

You can do all of what is described below with the [infrastructure](#infrastructure) tools recommended.

- **Vertical scale**: Put simply, for some time, it can just be easier to increase the size of your server as your resource demand grows.
- **Content Delivery Network (CDN)**: Sign up for a service like [Cloudflare](https://www.cloudflare.com/) or [Fastly](https://www.fastly.com/) to take the edge off of some of your traffic and protect from DDoS attacks.
- **Separation of concerns**: You may notice some parts of your application require more resources than others. For example, your database needs tons of storage, or your Redis instance takes a lot of RAM. In this case, it can be smarter to switch to either a managed service (e.g. RDS for managed DB, SQS for queues), or spin up a generic server specifically to use that tool.
- **Horizontal scale**: Spin more servers up, and stick a load balancer in front of them. Again managed services for this exist, or you can spin up a generic server with Forge/Ploi and use that for it. Just remember to [modify your scheduled tasks to only run on one server](https://laravel.com/docs/10.x/scheduling#running-tasks-on-one-server).
- **Self hosting**: Some non-app modules of your business might be cheaper to self-host. For example: CMS, Metabase, Websockets. Be careful with this however, as there can be some hidden catch of complexity/cost involved that can make it more attractive to go for the managed service.
- **Serverless**: There are two modes of thinking with serverless: pay to make the scale problems go away, or use it for infrequent, burstable task loads that don't need to be in your main app.

If you need _even more_ than that:
- **Splitting into services**: You can split portions of your app into new services, and scale those servers in particular. It's the same as `Separation of concerns`, but for your actual codebase. Note: `service` doesn't have to mean `microservice`.
- **Auto-scaling**: Here be dragons. Take time to learn the tools you need and understand them, or hire professional help. Keywords: Containerisation, orchestration. Or, YOLO and experiment with the [Spatie Dynamic Servers](https://spatie.be/docs/laravel-dynamic-servers/v1/introduction) package.
If you're at the point of needing these and more, congrats! You (hopefully) have a profitable & successful startup. You need to start hiring people. If you're still using this README, you're trying to melt steel with a lighter.

## Other recommendations for business operations, launching, etc.

While this isn't really within the scope of this project, I think it's still valuable to provide some starting recommendations for other entrepreneurs.

The following is a non-exhaustive, and potentially outdated list of recommendations. 

For more resources, such as for launching, advertising, sales, marketing, communities, and incorporating a business, [see here](https://writing.nikspyratos.com/Perceptions/Ambition+-+Careers+-+Entrepreneurship/Resources/Indie+Hacking+-+Solopreneurship+-+Startups+-+Founders).

### Helpdesk/Support

Honestly, using a `support@example.com` email address will be most of what you need. 

Helpdesk systems are only really needed as you need to start building support teams and processes.

Nevertheless, some options are: [Crisp.chat](https://crisp.chat), [GrooveHQ](https://www.groovehq.com/), [HelpScout](https://www.helpscout.com), and [HelpSpace](https://helpspace.com).

### Live Chat

Many of the [Support](#helpdesksupport) recommendations will already have a live chat feature. Otherwise, have a look at [Tawk.to](https://www.tawk.to/) and [Intercom](https://www.intercom.com/).

### Knowledgebase

While you're solo, I'd recommend one of the following:
- [VS Code](https://code.visualstudio.com/) with the [Markdown All In One](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one) extension.
- [Obsidian](https://obsidian.md/) ($50/yr for commercial use, cheaper than Notion)

Once you need to start having the knowledgebase available to others, [Notion](https://notion.so) is my go-to. Notion also supports making public pages, so you can also have your customer knowledgebase there.

### Accounting

I don't know too much in this space other than [Xero](https://www.xero.com).

### Terms & Conditions

- [Avodocs](https://www.avodocs.com/)
- [All sorts of policies available for free by Basecamp](https://github.com/basecamp/policies)
- [GetTerms](https://getterms.io/)

---

## TODO

- Get something working with this
- Filament: 
  - https://github.com/spatie/laravel-settings +  https://filamentphp.com/plugins/filament-spatie-settings 
  - https://filamentphp.com/plugins/pxlrbt-activity-log
    - Still need a custom resource for non-model CRUD actions
  - https://filamentphp.com/plugins/shuvroroy-spatie-laravel-health
    - Add extra utility actions in `Filament\Pages\HealthCheckResults`
- Landing page/marketing/content
  - Folio
    - https://github.com/snellingio/folio-markdown
  - Laravel analytics?
  - Find a nice usable starter template for landing pages
  - Contact form
    - Investigate [Lara Zeus](https://larazeus.com/)
  - Investigate if it's feasible to create something like or integrate [Jigsaw](https://jigsaw.tighten.com/) into this repo
- Toybox Website - Jigsaw? Or the default welcome page?
- UI recommendations
  - https://devdojo.com/pines
- Deploy script
  - `php artisan horizon:terminate` to get new code changes
- FPM auto restarter
