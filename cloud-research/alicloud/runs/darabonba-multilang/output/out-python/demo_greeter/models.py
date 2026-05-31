# -*- coding: utf-8 -*-
# This file is auto-generated, don't edit it. Thanks.
from Tea.model import TeaModel


class Greeting(TeaModel):
    def __init__(
        self,
        message: str = None,
        count: int = None,
    ):
        self.message = message
        self.count = count

    def validate(self):
        self.validate_required(self.message, 'message')
        self.validate_required(self.count, 'count')

    def to_map(self):
        _map = super().to_map()
        if _map is not None:
            return _map

        result = dict()
        if self.message is not None:
            result['message'] = self.message
        if self.count is not None:
            result['count'] = self.count
        return result

    def from_map(self, m: dict = None):
        m = m or dict()
        if m.get('message') is not None:
            self.message = m.get('message')
        if m.get('count') is not None:
            self.count = m.get('count')
        return self


