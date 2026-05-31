from pkgutil import extend_path
__path__ = extend_path(__path__, __name__)

import abc
import builtins
import datetime
import enum
import typing

import jsii
import publication
import typing_extensions

import typeguard
from importlib.metadata import version as _metadata_package_version
TYPEGUARD_MAJOR_VERSION = int(_metadata_package_version('typeguard').split('.')[0])

def check_type(argname: str, value: object, expected_type: typing.Any) -> typing.Any:
    if TYPEGUARD_MAJOR_VERSION <= 2:
        return typeguard.check_type(argname=argname, value=value, expected_type=expected_type) # type:ignore
    else:
        if isinstance(value, jsii._reference_map.InterfaceDynamicProxy): # pyright: ignore [reportAttributeAccessIssue]
           pass
        else:
            if TYPEGUARD_MAJOR_VERSION == 3:
                typeguard.config.collection_check_strategy = typeguard.CollectionCheckStrategy.ALL_ITEMS # type:ignore
                typeguard.check_type(value=value, expected_type=expected_type) # type:ignore
            else:
                typeguard.check_type(value=value, expected_type=expected_type, collection_check_strategy=typeguard.CollectionCheckStrategy.ALL_ITEMS) # type:ignore

from ._jsii import *


class Greeter(metaclass=jsii.JSIIMeta, jsii_type="greeting-construct.Greeter"):
    '''Builds greetings.

    jsii exposes this class to Python, Java, .NET, Go.
    '''

    def __init__(
        self,
        *,
        name: builtins.str,
        enthusiasm: typing.Optional[jsii.Number] = None,
    ) -> None:
        '''
        :param name: Who to greet.
        :param enthusiasm: Optional number of exclamation marks. Default: 1
        '''
        props = GreeterProps(name=name, enthusiasm=enthusiasm)

        jsii.create(self.__class__, self, [props])

    @jsii.member(jsii_name="greet")
    def greet(self) -> builtins.str:
        '''Return the greeting string.'''
        return typing.cast(builtins.str, jsii.invoke(self, "greet", []))


@jsii.data_type(
    jsii_type="greeting-construct.GreeterProps",
    jsii_struct_bases=[],
    name_mapping={"name": "name", "enthusiasm": "enthusiasm"},
)
class GreeterProps:
    def __init__(
        self,
        *,
        name: builtins.str,
        enthusiasm: typing.Optional[jsii.Number] = None,
    ) -> None:
        '''A greeting, expressed once in TypeScript and exposed to every jsii target.

        :param name: Who to greet.
        :param enthusiasm: Optional number of exclamation marks. Default: 1
        '''
        if __debug__:
            type_hints = typing.get_type_hints(_typecheckingstub__50e683381d460e67ba9ec4da319275dc8e844e579dc9bd6bf4ad94032b924bd7)
            check_type(argname="argument name", value=name, expected_type=type_hints["name"])
            check_type(argname="argument enthusiasm", value=enthusiasm, expected_type=type_hints["enthusiasm"])
        self._values: typing.Dict[builtins.str, typing.Any] = {
            "name": name,
        }
        if enthusiasm is not None:
            self._values["enthusiasm"] = enthusiasm

    @builtins.property
    def name(self) -> builtins.str:
        '''Who to greet.'''
        result = self._values.get("name")
        assert result is not None, "Required property 'name' is missing"
        return typing.cast(builtins.str, result)

    @builtins.property
    def enthusiasm(self) -> typing.Optional[jsii.Number]:
        '''Optional number of exclamation marks.

        :default: 1
        '''
        result = self._values.get("enthusiasm")
        return typing.cast(typing.Optional[jsii.Number], result)

    def __eq__(self, rhs: typing.Any) -> builtins.bool:
        return isinstance(rhs, self.__class__) and rhs._values == self._values

    def __ne__(self, rhs: typing.Any) -> builtins.bool:
        return not (rhs == self)

    def __repr__(self) -> str:
        return "GreeterProps(%s)" % ", ".join(
            k + "=" + repr(v) for k, v in self._values.items()
        )


__all__ = [
    "Greeter",
    "GreeterProps",
]

publication.publish()

def _typecheckingstub__50e683381d460e67ba9ec4da319275dc8e844e579dc9bd6bf4ad94032b924bd7(
    *,
    name: builtins.str,
    enthusiasm: typing.Optional[jsii.Number] = None,
) -> None:
    """Type checking stubs"""
    pass
