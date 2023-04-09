<?php

declare(strict_types=1);

/*
 * This file is part of generic monitoring response package.
 *
 * (c) Martin Miskovic <miskovic.martin@gmail.com>
 *
 * For the full copyright and license information, please view
 * the LICENSE file that was distributed with this source code.
 */

use Flexis\PhpCsFixer\RuleSet\Sets\Php81;
use PhpCsFixer\Config;
use PhpCsFixer\Finder;

$finder = new Finder();
$finder->in(__DIR__);
$finder->append([
    '.php-cs-fixer.dist.php',
]);

// Pick a configuration based on php version
$ruleSet = new Php81();
$ruleSet->setHeader(<<<'EOF'
    This file is part of generic monitoring response package.

    (c) Martin Miskovic <miskovic.martin@gmail.com>

    For the full copyright and license information, please view
    the LICENSE file that was distributed with this source code.
    EOF);

$config = new Config();
$config->setRules($ruleSet->getRules());
$config->setFinder($finder);
$config->setCacheFile('.php-cs-fixer.cache');

return $config;
