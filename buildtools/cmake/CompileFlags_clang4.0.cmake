# Copyright (C) 2017  Christian Berger
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

# Warning flags based on and generated from: https://raw.githubusercontent.com/Barro/compiler-warnings/master/clang/warnings-clang-unique-4.0.txt
set(CLANG40_CXX_WARNING_FLAGS " \
    -pedantic \
    -pedantic-errors \
    -Werror \
    -W \
    -W#pragma-messages \
    -W#warnings \
    -Wabi \
    -Wabsolute-value \
    -Wabstract-final-class \
    -Waddress \
    -Waddress-of-temporary \
    -Wno-error=aggregate-return \
    -Wall \
    -Wambiguous-macro \
    -Wambiguous-member-template \
    -Warc \
    -Warc-maybe-repeated-use-of-weak \
    -Warc-non-pod-memaccess \
    -Warc-repeated-use-of-weak \
    -Warc-retain-cycles \
    -Warc-unsafe-retained-assign \
    -Warray-bounds \
    -Warray-bounds-pointer-arithmetic \
    -Wasm \
    -Wasm-ignored-qualifier \
    -Wasm-operand-widths \
    -Wat-protocol \
    -Watomic-properties \
    -Wattributes \
    -Wauto-import \
    -Wavailability \
    -Wbackend-plugin \
    -Wbad-function-cast \
    -Wno-error=bind-to-temporary-copy \
    -Wbitfield-constant-conversion \
    -Wbitfield-width \
    -Wbitwise-op-parentheses \
    -Wblock-capture-autoreleasing \
    -Wbool-conversion \
    -Wbool-conversions \
    -Wbridge-cast \
    -Wbuiltin-macro-redefined \
    -Wbuiltin-requires-header \
    -Wc++-compat \
    -Wc++14-binary-literal \
    -Wc++14-compat \
    -Wc++14-compat-pedantic \
    -Wc++14-extensions \
    -Wc++1y-extensions \
    -Wc++1z-compat \
    -Wc++1z-extensions \
    -Wc11-extensions \
    -Wc99-compat \
    -Wc99-extensions \
    -Wcast-align \
    -Wcast-of-sel-type \
    -Wcast-qual \
    -Wchar-align \
    -Wchar-subscripts \
    -WCL4 \
    -Wclang-cl-pch \
    -Wclass-varargs \
    -Wcomment \
    -Wcomments \
    -Wcompare-distinct-pointer-types \
    -Wconditional-uninitialized \
    -Wconfig-macros \
    -Wconstant-conversion \
    -Wconsumed \
    -Wconversion \
    -Wconversion-null \
    -Wcovered-switch-default \
    -Wcstring-format-directive \
    -Wctor-dtor-privacy \
    -Wcuda-compat \
    -Wcustom-atomic-properties \
    -Wdangling-else \
    -Wdangling-field \
    -Wdealloc-in-category \
    -Wdelegating-ctor-cycles \
    -Wdelete-incomplete \
    -Wdelete-non-virtual-dtor \
    -Wdeprecated \
    -Wdeprecated-attributes \
    -Wdeprecated-declarations \
    -Wdeprecated-dynamic-exception-spec \
    -Wdeprecated-implementations \
    -Wdeprecated-increment-bool \
    -Wdeprecated-objc-isa-usage \
    -Wdeprecated-objc-pointer-introspection \
    -Wdeprecated-objc-pointer-introspection-performSelector \
    -Wdeprecated-register \
    -Wdeprecated-writable-strings \
    -Wdisabled-optimization \
    -Wdiscard-qual \
    -Wdistributed-object-modifiers \
    -Wdiv-by-zero \
    -Wdivision-by-zero \
    -Wdocumentation \
    -Wdocumentation-deprecated-sync \
    -Wdocumentation-html \
    -Wdocumentation-pedantic \
    -Wdocumentation-unknown-command \
    -Wdouble-promotion \
    -Wduplicate-decl-specifier \
    -Wduplicate-method-arg \
    -Wduplicate-method-match \
    -Wdynamic-exception-spec \
    -Weffc++ \
    -Wempty-body \
    -Wendif-labels \
    -Wenum-conversion \
    -Wenum-too-large \
    -Wexceptions \
    -Wno-error=exit-time-destructors \
    -Wexpansion-to-defined \
    -Wexplicit-initialize-call \
    -Wextern-c-compat \
    -Wextra \
    -Wextra-semi \
    -Wextra-tokens \
    -Wfallback \
    -Wflag-enum \
    -Wflexible-array-extensions \
    -Wfloat-conversion \
    -Wfloat-overflow-conversion \
    -Wfloat-zero-conversion \
    -Wfor-loop-analysis \
    -Wformat \
    -Wformat-extra-args \
    -Wformat-invalid-specifier \
    -Wformat-non-iso \
    -Wformat-nonliteral \
    -Wformat-pedantic \
    -Wformat-security \
    -Wformat-y2k \
    -Wformat-zero-length \
    -Wformat=2 \
    -Wfour-char-constants \
    -Wfunction-def-in-objc-container \
    -Wfuture-compat \
    -Wgcc-compat \
    -Wglobal-constructors \
    -Wgnu \
    -Wgnu-alignof-expression \
    -Wgnu-anonymous-struct \
    -Wgnu-auto-type \
    -Wgnu-binary-literal \
    -Wgnu-case-range \
    -Wgnu-complex-integer \
    -Wgnu-compound-literal-initializer \
    -Wgnu-conditional-omitted-operand \
    -Wgnu-designator \
    -Wgnu-empty-initializer \
    -Wgnu-empty-struct \
    -Wgnu-flexible-array-initializer \
    -Wgnu-flexible-array-union-member \
    -Wgnu-folding-constant \
    -Wgnu-imaginary-constant \
    -Wgnu-include-next \
    -Wgnu-label-as-value \
    -Wgnu-redeclared-enum \
    -Wgnu-statement-expression \
    -Wgnu-static-float-init \
    -Wgnu-string-literal-operator-template \
    -Wgnu-union-cast \
    -Wgnu-variable-sized-type-not-at-end \
    -Wgnu-zero-line-directive \
    -Wgnu-zero-variadic-macro-arguments \
    -Wheader-hygiene \
    -Wignored-attributes \
    -Wignored-optimization-argument \
    -Wignored-pragma-intrinsic \
    -Wignored-pragmas \
    -Wignored-qualifiers \
    -Wimplicit \
    -Wimplicit-atomic-properties \
    -Wimplicit-conversion-floating-point-to-bool \
    -Wimplicit-fallthrough \
    -Wimplicit-fallthrough-per-function \
    -Wimplicit-function-declaration \
    -Wimplicit-int \
    -Wimplicitly-unsigned-literal \
    -Wimport \
    -Wincompatible-exception-spec \
    -Wincompatible-function-pointer-types \
    -Wincompatible-ms-struct \
    -Wincompatible-pointer-types \
    -Wincompatible-pointer-types-discards-qualifiers \
    -Wincomplete-module \
    -Wincomplete-umbrella \
    -Winconsistent-dllimport \
    -Winconsistent-missing-override \
    -Wincrement-bool \
    -WIndependentClass-attribute \
    -Winfinite-recursion \
    -Winit-self \
    -Winitializer-overrides \
    -Winline \
    -Winline-asm \
    -Wint-conversion \
    -Wint-conversions \
    -Wint-to-pointer-cast \
    -Wint-to-void-pointer-cast \
    -Winvalid-command-line-argument \
    -Winvalid-iboutlet \
    -Winvalid-noreturn \
    -Winvalid-offsetof \
    -Winvalid-or-nonexistent-directory \
    -Winvalid-pch \
    -Winvalid-pp-token \
    -Winvalid-source-encoding \
    -Wkeyword-compat \
    -Wkeyword-macro \
    -Wknr-promoted-parameter \
    -Wliblto \
    -Wliteral-conversion \
    -Wliteral-range \
    -Wlogical-not-parentheses \
    -Wlogical-op-parentheses \
    -Wlong-long \
    -Wloop-analysis \
    -Wmacro-redefined \
    -Wmain \
    -Wmain-return-type \
    -Wmalformed-warning-check \
    -Wmax-unsigned-zero \
    -Wmethod-signatures \
    -Wmicrosoft \
    -Wmicrosoft-anon-tag \
    -Wmicrosoft-cast \
    -Wmicrosoft-charize \
    -Wmicrosoft-comment-paste \
    -Wmicrosoft-const-init \
    -Wmicrosoft-cpp-macro \
    -Wmicrosoft-default-arg-redefinition \
    -Wmicrosoft-end-of-file \
    -Wmicrosoft-enum-forward-reference \
    -Wmicrosoft-enum-value \
    -Wmicrosoft-exception-spec \
    -Wmicrosoft-explicit-constructor-call \
    -Wmicrosoft-extra-qualification \
    -Wmicrosoft-fixed-enum \
    -Wmicrosoft-flexible-array \
    -Wmicrosoft-goto \
    -Wmicrosoft-include \
    -Wmicrosoft-mutable-reference \
    -Wmicrosoft-pure-definition \
    -Wmicrosoft-redeclare-static \
    -Wmicrosoft-sealed \
    -Wmicrosoft-template \
    -Wmicrosoft-union-member-reference \
    -Wmicrosoft-unqualified-friend \
    -Wmicrosoft-using-decl \
    -Wmicrosoft-void-pseudo-dtor \
    -Wmismatched-parameter-types \
    -Wmismatched-return-types \
    -Wmismatched-tags \
    -Wmissing-braces \
    -Wmissing-declarations \
    -Wmissing-field-initializers \
    -Wmissing-format-attribute \
    -Wmissing-include-dirs \
    -Wmissing-method-return-type \
    -Wmissing-noreturn \
    -Wmodule-conflict \
    -Wmodule-file-extension \
    -Wmost \
    -Wmove \
    -Wmsvc-include \
    -Wmultichar \
    -Wnarrowing \
    -Wnested-externs \
    -Wnew-returns-null \
    -Wnewline-eof \
    -Wnon-gcc \
    -Wnon-literal-null-conversion \
    -Wnon-modular-include-in-framework-module \
    -Wnon-modular-include-in-module \
    -Wnon-pod-varargs \
    -Wnon-virtual-dtor \
    -Wnonnull \
    -Wnonportable-cfstrings \
    -WNSObject-attribute \
    -Wnull-arithmetic \
    -Wnull-character \
    -Wnull-conversion \
    -Wnull-dereference \
    -Wnullability \
    -Wnullability-completeness \
    -Wnullability-completeness-on-arrays \
    -Wnullability-declspec \
    -Wnullability-inferred-on-nested-type \
    -Wnullable-to-nonnull-conversion \
    -Wobjc-cocoa-api \
    -Wobjc-designated-initializers \
    -Wobjc-literal-compare \
    -Wobjc-literal-conversion \
    -Wobjc-method-access \
    -Wobjc-missing-super-calls \
    -Wobjc-multiple-method-names \
    -Wobjc-noncopy-retain-block-property \
    -Wobjc-nonunified-exceptions \
    -Wobjc-property-implementation \
    -Wobjc-property-no-attribute \
    -Wobjc-property-synthesis \
    -Wobjc-protocol-method-implementation \
    -Wobjc-protocol-qualifiers \
    -Wobjc-readonly-with-setter-property \
    -Wobjc-redundant-api-use \
    -Wobjc-redundant-literal-use \
    -Wobjc-root-class \
    -Wobjc-string-compare \
    -Wobjc-string-concatenation \
    -Wold-style-cast \
    -Wold-style-definition \
    -Wopencl-unsupported-rgba \
    -Wopenmp-clauses \
    -Wopenmp-loop-form \
    -Wopenmp-target \
    -Woption-ignored \
    -Wout-of-line-declaration \
    -Wover-aligned \
    -Woverflow \
    -Woverlength-strings \
    -Woverloaded-shift-op-parentheses \
    -Woverloaded-virtual \
    -Woverriding-method-mismatch \
    -Wpacked \
    -Wparentheses \
    -Wparentheses-equality \
    -Wpartial-availability \
    -Wpass-failed \
    -Wpedantic \
    -Wpessimizing-move \
    -Wpointer-arith \
    -Wpointer-bool-conversion \
    -Wpointer-to-int-cast \
    -Wpotentially-evaluated-expression \
    -Wpragmas \
    -Wprivate-extern \
    -Wprivate-module \
    -Wprofile-instr-out-of-date \
    -Wprofile-instr-unprofiled \
    -Wproperty-access-dot-syntax \
    -Wproperty-attribute-mismatch \
    -Wprotocol \
    -Wrange-loop-analysis \
    -Wreceiver-expr \
    -Wreceiver-forward-class \
    -Wredeclared-class-member \
    -Wredundant-decls \
    -Wredundant-move \
    -Wregister \
    -Wreinterpret-base-class \
    -Wreorder \
    -Wreserved-id-macro \
    -Wreserved-user-defined-literal \
    -Wreturn-stack-address \
    -Wreturn-type \
    -Wreturn-type-c-linkage \
    -Wsection \
    -Wselector \
    -Wselector-type-mismatch \
    -Wself-assign \
    -Wself-assign-field \
    -Wself-move \
    -Wsemicolon-before-method-body \
    -Wsentinel \
    -Wsequence-point \
    -Wserialized-diagnostics \
    -Wshadow \
    -Wshadow-all \
    -Wshadow-field-in-constructor \
    -Wshadow-field-in-constructor-modified \
    -Wshadow-ivar \
    -Wshadow-uncaptured-local \
    -Wshift-op-parentheses \
    -Wshorten-64-to-32 \
    -Wsign-compare \
    -Wsign-conversion \
    -Wsign-promo \
    -Wsigned-enum-bitfield \
    -Wsizeof-array-argument \
    -Wsizeof-array-decay \
    -Wsizeof-pointer-memaccess \
    -Wsometimes-uninitialized \
    -Wsource-uses-openmp \
    -Wspir-compat \
    -Wstack-protector \
    -Wstatic-float-init \
    -Wstatic-in-inline \
    -Wstatic-local-in-inline \
    -Wstatic-self-init \
    -Wstrict-aliasing \
    -Wstrict-aliasing=0 \
    -Wstrict-aliasing=1 \
    -Wstrict-aliasing=2 \
    -Wstrict-overflow \
    -Wstrict-overflow=0 \
    -Wstrict-overflow=1 \
    -Wstrict-overflow=2 \
    -Wstrict-overflow=3 \
    -Wstrict-overflow=4 \
    -Wstrict-overflow=5 \
    -Wstrict-prototypes \
    -Wstrict-selector-match \
    -Wstring-compare \
    -Wstring-conversion \
    -Wstring-plus-char \
    -Wstring-plus-int \
    -Wstrncat-size \
    -Wsuper-class-method-mismatch \
    -Wswitch \
    -Wswitch-bool \
    -Wno-error=switch-default \
    -Wswitch-enum \
    -Wsynth \
    -Wtautological-compare \
    -Wtautological-constant-out-of-range-compare \
    -Wtautological-overlap-compare \
    -Wtautological-pointer-compare \
    -Wtautological-undefined-compare \
    -Wthread-safety \
    -Wthread-safety-analysis \
    -Wthread-safety-attributes \
    -Wthread-safety-beta \
    -Wthread-safety-negative \
    -Wthread-safety-precise \
    -Wthread-safety-reference \
    -Wthread-safety-verbose \
    -Wtrigraphs \
    -Wtype-limits \
    -Wtype-safety \
    -Wunavailable-declarations \
    -Wundeclared-selector \
    -Wundefined-bool-conversion \
    -Wundefined-func-template \
    -Wundefined-reinterpret-cast \
    -Wundefined-var-template \
    -Wunevaluated-expression \
    -Wunguarded-availability \
    -Wunicode \
    -Wuninitialized \
    -Wunknown-argument \
    -Wunknown-attributes \
    -Wunknown-pragmas \
    -Wunknown-sanitizers \
    -Wunknown-warning-option \
    -Wunnamed-type-template-args \
    -Wunneeded-internal-declaration \
    -Wunneeded-member-function \
    -Wunreachable-code \
    -Wunreachable-code-aggressive \
    -Wunreachable-code-break \
    -Wunreachable-code-loop-increment \
    -Wno-error=unreachable-code-return \
    -Wunsequenced \
    -Wunsupported-cb \
    -Wunsupported-friend \
    -Wunsupported-nan \
    -Wunused \
    -Wunused-argument \
    -Wunused-command-line-argument \
    -Wunused-comparison \
    -Wunused-const-variable \
    -Wunused-exception-parameter \
    -Wunused-function \
    -Wunused-getter-return-value \
    -Wunused-label \
    -Wunused-local-typedef \
    -Wunused-local-typedefs \
    -Wunused-member-function \
    -Wunused-parameter \
    -Wunused-private-field \
    -Wunused-property-ivar \
    -Wunused-result \
    -Wunused-value \
    -Wunused-variable \
    -Wused-but-marked-unused \
    -Wuser-defined-literals \
    -Wuser-defined-warnings \
    -Wvarargs \
    -Wvariadic-macros \
    -Wvector-conversion \
    -Wvector-conversions \
    -Wvexing-parse \
    -Wvisibility \
    -Wvla \
    -Wvla-extension \
    -Wvolatile-register-var \
    -Wwritable-strings \
    -Wwrite-strings \
    -Wzero-length-array")

