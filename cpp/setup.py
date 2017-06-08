"""
Emerald, the language agnostic templating engine.
Copyright 2016-2017, Emerald Language (MIT)
"""

from setuptools import setup

setup(
    name='Emerald',

    version='1.0.0',

    description='Emerald, the language agnostic templating engine.',

    url='https://github.com/emerald-lang/emerald',

    author='Andrew Robert McBurney, Dave Pagurek van Mossel, Yu Chen Hou',

    author_email='andrewrobertmcburney@gmail.com, davepagurek@gmail.com, me@yuchenhou.com',

    license='MIT',

    classifiers=[
        'Development Status :: 3 - Alpha',
        'Intended Audience :: Developers',
        'Topic :: Software Development :: Template Engines',
        'License :: OSI Approved :: MIT License',
        'Programming Language :: Python :: 2'
    ],

    keywords='sample setuptools development',

    extras_require={
        'test': ['cpplint']
    }
)
