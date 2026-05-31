# -*- coding: utf-8 -*-
# This file is auto-generated, don't edit it. Thanks.
from demo_greeter import models as greeter_models


class Client:
    """
    Minimal Darabonba module: one DSL source, generated into many languages.
    """
    def __init__(self):
        pass

    @staticmethod
    def build(
        name: str,
    ) -> greeter_models.Greeting:
        """
        Imperative logic written directly in the DSL — this is Alibaba's
        "customization = code in the spec" mechanism in miniature.
        """
        g = greeter_models.Greeting(
            message=name,
            count=1
        )
        return g
